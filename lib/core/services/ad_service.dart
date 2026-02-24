import 'package:flutter/foundation.dart';
import '../constants/app_constants.dart';

/// Ad service stub - will be configured when AdMob is set up
class AdService {
  AdService._();
  static final AdService instance = AdService._();

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (!AppConstants.adsEnabled) {
      debugPrint('AdService: Ads are disabled');
      return;
    }
    // TODO: Initialize Google Mobile Ads
    _isInitialized = true;
    debugPrint('AdService: Initialized');
  }

  bool get isInitialized => _isInitialized;

  Future<void> showBannerAd() async {
    if (!AppConstants.adsEnabled || !_isInitialized) return;
    // TODO: Show banner ad
  }

  Future<void> showInterstitialAd() async {
    if (!AppConstants.adsEnabled || !_isInitialized) return;
    // TODO: Show interstitial ad
  }

  Future<bool> showRewardedAd() async {
    if (!AppConstants.adsEnabled || !_isInitialized) return false;
    // TODO: Show rewarded ad and return true if user watched
    return false;
  }

  void dispose() {
    // TODO: Dispose ad resources
  }
}
