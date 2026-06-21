import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../constants/app_constants.dart';
import '../../data/datasources/local_database.dart';
import 'ad_service.dart';

/// Manages Go Pro in-app purchase.
///
/// Benefits:
/// - All ads removed (banner, interstitial, rewarded)
/// - All premium themes unlocked
/// - +1 bonus hint per puzzle (within 50% cap)
class IapService {
  IapService._();
  static final IapService instance = IapService._();

  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  bool _isAvailable = false;
  ProductDetails? _proProduct;
  bool _purchasePending = false;

  bool get isAvailable => _isAvailable;
  bool get isPro => LocalDatabase.instance.getProStatus();
  bool get purchasePending => _purchasePending;
  ProductDetails? get proProduct => _proProduct;

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

  /// Purchase Go Pro.
  Future<bool> purchasePro() async {
    if (kDebugMode || kIsWeb) {
      debugPrint('IapService: DEV MODE - Mocking successful purchase!');
      LocalDatabase.instance.setProStatus(true);
      AdService.instance.disposeBanner();
      return true;
    }

    if (!_isAvailable || _proProduct == null) {
      debugPrint('IapService: Cannot purchase — store or product unavailable');
      return false;
    }

    _purchasePending = true;

    final purchaseParam = PurchaseParam(productDetails: _proProduct!);
    try {
      await _iap.buyNonConsumable(purchaseParam: purchaseParam);
      return true;
    } catch (e) {
      debugPrint('IapService: Purchase failed: $e');
      _purchasePending = false;
      return false;
    }
  }

  /// Restore previous purchases.
  Future<void> restorePurchases() async {
    if (!_isAvailable) return;
    await _iap.restorePurchases();
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    for (final purchase in purchaseDetailsList) {
      if (purchase.productID != AppConstants.proProductId) continue;

      switch (purchase.status) {
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          _verifyAndDeliver(purchase);
          break;
        case PurchaseStatus.error:
          debugPrint('IapService: Purchase error: ${purchase.error}');
          _purchasePending = false;
          break;
        case PurchaseStatus.canceled:
          debugPrint('IapService: Purchase canceled');
          _purchasePending = false;
          break;
        case PurchaseStatus.pending:
          debugPrint('IapService: Purchase pending');
          break;
      }

      if (purchase.pendingCompletePurchase) {
        _iap.completePurchase(purchase);
      }
    }
  }

  void _verifyAndDeliver(PurchaseDetails purchase) {
    // For now, trust the store receipt. Add server-side verification for production.
    LocalDatabase.instance.setProStatus(true);
    _purchasePending = false;

    // Reinitialize ad service to disable ads
    AdService.instance.disposeBanner();
    debugPrint('IapService: Pro activated! Ads disabled.');
  }

  void dispose() {
    _subscription?.cancel();
  }
}
