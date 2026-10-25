import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:cryptiq/core/constants/app_constants.dart';
import 'package:cryptiq/core/services/iap_service.dart';
import 'package:cryptiq/data/datasources/local_database.dart';
import 'helpers/test_database.dart';

/// A Google Play stand-in: purchases are delivered only when the test says so.
class FakePlay extends InAppPurchasePlatform with MockPlatformInterfaceMixin {
  final updates = StreamController<List<PurchaseDetails>>.broadcast();
  bool available = true;
  List<PurchaseDetails> owned = [];
  int buyCalls = 0;
  final completed = <PurchaseDetails>[];

  @override
  Stream<List<PurchaseDetails>> get purchaseStream => updates.stream;

  @override
  Future<bool> isAvailable() async => available;

  @override
  Future<ProductDetailsResponse> queryProductDetails(Set<String> identifiers) async =>
      ProductDetailsResponse(productDetails: [
        ProductDetails(
          id: AppConstants.proProductId,
          title: 'CryptiQ Pro',
          description: '',
          price: 'Rp49.000',
          rawPrice: 49000,
          currencyCode: 'IDR',
        ),
      ], notFoundIDs: []);

  @override
  Future<bool> buyNonConsumable({required PurchaseParam purchaseParam}) async {
    buyCalls++;
    return true; // the Play dialog opened; nothing has been paid yet
  }

  @override
  Future<void> restorePurchases({String? applicationUserName}) async {
    if (owned.isNotEmpty) updates.add(owned);
  }

  @override
  Future<void> completePurchase(PurchaseDetails purchase) async => completed.add(purchase);

  void deliver(PurchaseStatus status) => updates.add([purchase(status)]);
}

PurchaseDetails purchase(PurchaseStatus status) => PurchaseDetails(
      purchaseID: 'order-1',
      productID: AppConstants.proProductId,
      verificationData: PurchaseVerificationData(
          localVerificationData: '', serverVerificationData: '', source: 'google_play'),
      transactionDate: '0',
      status: status,
    )..pendingCompletePurchase = status != PurchaseStatus.pending;

Future<void> settle() => Future<void>.delayed(Duration.zero);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late InAppPurchase plugin;
  setUpAll(() async {
    await initTestDatabase();
    // On Android, the first access registers the real billing client, which
    // tries to reach native code. Grab the instance as another platform once.
    debugDefaultTargetPlatformOverride = TargetPlatform.linux;
    plugin = InAppPurchase.instance;
    debugDefaultTargetPlatformOverride = null; // tests run as Android
  });

  late FakePlay play;
  late IapService iap;
  late List<IapEvent> events;

  setUp(() async {
    await LocalDatabase.instance.setProStatus(false);
    play = FakePlay();
    InAppPurchasePlatform.instance = play;
    iap = IapService.forTesting(plugin);
    events = [];
    iap.events.listen(events.add);
  });

  test('opening the Play dialog does not activate Pro', () async {
    await iap.initialize();
    expect(await iap.purchasePro(), isTrue);
    await settle();
    expect(play.buyCalls, 1);
    expect(iap.isPro, isFalse);
    expect(events, isEmpty);
  });

  test('Pro activates (and is acknowledged) only when Play reports the purchase', () async {
    await iap.initialize();
    await iap.purchasePro();
    play.deliver(PurchaseStatus.purchased);
    await settle();
    expect(iap.isPro, isTrue);
    expect(events, [IapEvent.activated]);
    expect(play.completed, hasLength(1));
  });

  test('cancelling the Play dialog leaves Pro off', () async {
    await iap.initialize();
    await iap.purchasePro();
    play.deliver(PurchaseStatus.canceled);
    await settle();
    expect(iap.isPro, isFalse);
    expect(events, [IapEvent.canceled]);
  });

  test('a pending payment activates Pro when it completes', () async {
    await iap.initialize();
    await iap.purchasePro();
    play.deliver(PurchaseStatus.pending);
    await settle();
    expect(iap.isPro, isFalse);
    play.deliver(PurchaseStatus.purchased);
    await settle();
    expect(iap.isPro, isTrue);
    expect(events, [IapEvent.pending, IapEvent.activated]);
  });

  test('a purchase completed while the app was closed is delivered and '
      'acknowledged at startup', () async {
    play.owned = [purchase(PurchaseStatus.restored)];
    await iap.initialize();
    await settle();
    expect(iap.isPro, isTrue);
    expect(play.completed, hasLength(1), reason: 'Play refunds unacknowledged purchases');
  });

  test('Restore Purchases reports whether Pro was found', () async {
    await iap.initialize();
    expect(await iap.restorePurchases(timeout: const Duration(milliseconds: 50)), isFalse);

    play.owned = [purchase(PurchaseStatus.restored)];
    expect(await iap.restorePurchases(), isTrue);
    expect(iap.isPro, isTrue);
  });

  test('purchasePro returns false when the store is unavailable', () async {
    play.available = false;
    await iap.initialize();
    expect(await iap.purchasePro(), isFalse);
  });
}
