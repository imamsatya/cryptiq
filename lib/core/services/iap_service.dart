import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../constants/app_constants.dart';
import '../../data/datasources/local_database.dart';
import 'ad_service.dart';

/// Outcome of a purchase, reported on [IapService.events].
enum IapEvent { activated, pending, canceled, failed }

/// Manages Go Pro in-app purchase.
///
/// Benefits:
/// - All ads removed (banner, interstitial, rewarded)
/// - Unlimited hints and every level unlocked
/// - All premium themes unlocked
/// - Pass & Play with up to 6 players and 10 rounds
class IapService {
  IapService._(this._iap, {required this.mockPurchases});
  static final IapService instance = IapService._(InAppPurchase.instance,
      mockPurchases: kDebugMode || kIsWeb);

  @visibleForTesting
  factory IapService.forTesting(InAppPurchase iap) =>
      IapService._(iap, mockPurchases: false);

  final InAppPurchase _iap;

  /// Debug and web builds can't reach Google Play: purchases succeed at once.
  final bool mockPurchases;

  StreamSubscription<List<PurchaseDetails>>? _subscription;
  final _events = StreamController<IapEvent>.broadcast();

  bool _isAvailable = false;
  ProductDetails? _proProduct;

  bool get isAvailable => _isAvailable;
  bool get isPro => LocalDatabase.instance.getProStatus();
  ProductDetails? get proProduct => _proProduct;

  /// Purchase results. A purchase completes after [purchasePro] returns —
  /// sometimes much later (pending payments), or on the next app start.
  Stream<IapEvent> get events => _events.stream;

  String get proPriceString => _proProduct?.price ?? '\$${AppConstants.proPrice}';

  /// Initialize IAP and listen for purchase updates.
  Future<void> initialize() async {
    if (kIsWeb) {
      debugPrint('IapService: IAP not available on web');
      return;
    }

    _isAvailable = await _iap.isAvailable();
    if (!_isAvailable) {
      debugPrint('IapService: Store not available');
      return;
    }

    // Listen for purchase updates
    _subscription = _iap.purchaseStream.listen(
      _onPurchaseUpdate,
      onDone: () => _subscription?.cancel(),
      onError: (error) => debugPrint('IapService: Stream error: $error'),
    );

    // Load product details
    await _loadProducts();

    // Deliver purchases that completed while the app was closed (e.g. a
    // pending payment) and acknowledge them: Google Play refunds purchases
    // that aren't acknowledged within 3 days.
    if (defaultTargetPlatform == TargetPlatform.android) {
      try {
        await _iap.restorePurchases();
      } catch (e) {
        debugPrint('IapService: Startup restore failed: $e');
      }
    }
    debugPrint('IapService: Initialized');
  }

  Future<void> _loadProducts() async {
    final response = await _iap.queryProductDetails({AppConstants.proProductId});
    if (response.notFoundIDs.isNotEmpty) {
      debugPrint('IapService: Product not found: ${response.notFoundIDs}');
    }
    if (response.productDetails.isNotEmpty) {
      _proProduct = response.productDetails.first;
      debugPrint('IapService: Product loaded: ${_proProduct!.title} - ${_proProduct!.price}');
    }
  }

  /// Starts the Google Play purchase flow. Returns false if it couldn't be
  /// started; otherwise the outcome arrives on [events].
  Future<bool> purchasePro() async {
    if (mockPurchases) {
      debugPrint('IapService: DEV MODE - Mocking successful purchase!');
      _activate();
      return true;
    }

    if (!_isAvailable || _proProduct == null) {
      debugPrint('IapService: Cannot purchase — store or product unavailable');
      return false;
    }

    try {
      return await _iap.buyNonConsumable(
          purchaseParam: PurchaseParam(productDetails: _proProduct!));
    } catch (e) {
      debugPrint('IapService: Purchase failed: $e');
      return false;
    }
  }

  /// Asks Google Play for past purchases. Returns whether Pro is active
  /// afterwards; restored purchases arrive on the purchase stream, so this
  /// waits up to [timeout] for them.
  Future<bool> restorePurchases({Duration timeout = const Duration(seconds: 5)}) async {
    if (isPro) return true;
    if (!_isAvailable) return false;

    final restored = Completer<bool>();
    final sub = events.listen((e) {
      if (e == IapEvent.activated && !restored.isCompleted) restored.complete(true);
    });
    try {
      await _iap.restorePurchases();
      return await restored.future.timeout(timeout, onTimeout: () => isPro);
    } catch (e) {
      debugPrint('IapService: Restore failed: $e');
      return isPro;
    } finally {
      await sub.cancel();
    }
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    for (final purchase in purchaseDetailsList) {
      if (purchase.productID != AppConstants.proProductId) continue;

      switch (purchase.status) {
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          // For now, trust the store receipt. Add server-side verification for production.
          _activate();
          break;
        case PurchaseStatus.error:
          debugPrint('IapService: Purchase error: ${purchase.error}');
          _events.add(IapEvent.failed);
          break;
        case PurchaseStatus.canceled:
          debugPrint('IapService: Purchase canceled');
          _events.add(IapEvent.canceled);
          break;
        case PurchaseStatus.pending:
          debugPrint('IapService: Purchase pending');
          _events.add(IapEvent.pending);
          break;
      }

      if (purchase.pendingCompletePurchase) {
        _iap.completePurchase(purchase);
      }
    }
  }

  void _activate() {
    LocalDatabase.instance.setProStatus(true);
    // Reinitialize ad service to disable ads
    AdService.instance.disposeBanner();
    _events.add(IapEvent.activated);
    debugPrint('IapService: Pro activated! Ads disabled.');
  }

  void dispose() {
    _subscription?.cancel();
    _events.close();
  }
}
