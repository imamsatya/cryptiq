import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../constants/app_constants.dart';
import '../../data/datasources/local_database.dart';

/// Manages all ad operations: banner, interstitial, rewarded.
///
/// Interstitial trigger logic (OR):
///   A) ≥3 levels completed + ≥2 min since last ad
///   B) ≥4 min since last ad (any level count)
///
/// Safety: max 8 interstitials/hour, skip first 5 levels.
class AdService {
  AdService._();
  static final AdService instance = AdService._();

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  // --- Interstitial tracking ---
  InterstitialAd? _interstitialAd;
  int _levelsSinceLastAd = 0;
  DateTime _lastAdShownAt = DateTime(2000);
  final List<DateTime> _adTimestamps = []; // for hourly cap

  // --- Banner ---
  BannerAd? _bannerAd;
  bool _isBannerLoaded = false;
  bool get isBannerLoaded => _isBannerLoaded;
  BannerAd? get bannerAd => _bannerAd;

  // --- Rewarded ---
  RewardedAd? _rewardedAd;

  // --- Pro status ---
  bool get isPro => LocalDatabase.instance.getProStatus();

  // ==========  INITIALIZE  ==========

  Future<void> initialize() async {
    if (!AppConstants.adsEnabled || isPro) {
      debugPrint('AdService: Ads disabled or user is Pro');
      return;
    }
    if (kIsWeb) {
      debugPrint('AdService: Web detected, mocking ads for testing');
      _isInitialized = true;
      return;
    }
    try {
      await MobileAds.instance.initialize();
      _isInitialized = true;
      debugPrint('AdService: Initialized');
      _preloadInterstitial();
      _preloadRewarded();
    } catch (e) {
      debugPrint('AdService: Init failed: $e');
    }
  }

  // ==========  BANNER  ==========

  void loadBanner({required AdSize size, required Function(bool) onLoaded}) {
    if (!_shouldShowAds()) {
      onLoaded(false);
      return;
    }
    if (kIsWeb) {
      _isBannerLoaded = true;
      onLoaded(true);
      return;
    }

    _bannerAd?.dispose();
    _bannerAd = BannerAd(
      adUnitId: AppConstants.bannerAdUnitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          _isBannerLoaded = true;
          onLoaded(true);
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Banner failed: ${error.message}');
          _isBannerLoaded = false;
          ad.dispose();
          onLoaded(false);
        },
      ),
    )..load();
  }

  void disposeBanner() {
    _bannerAd?.dispose();
    _bannerAd = null;
    _isBannerLoaded = false;
  }

  // ==========  INTERSTITIAL  ==========

  void _preloadInterstitial() {
    if (!_shouldShowAds()) return;

    InterstitialAd.load(
      adUnitId: AppConstants.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          debugPrint('AdService: Interstitial preloaded');
        },
        onAdFailedToLoad: (error) {
          debugPrint('AdService: Interstitial preload failed: ${error.message}');
          _interstitialAd = null;
        },
      ),
    );
  }

  /// Call after a level is completed (not failed).
  void onLevelCompleted() {
    _levelsSinceLastAd++;
  }

  /// Check if interstitial should show using OR-logic:
  ///   A) ≥3 levels + ≥2 min since last ad
  ///   B) ≥4 min since last ad
  bool shouldShowInterstitial() {
    if (!_shouldShowAds()) return false;

    // Skip first N levels ever completed
    final totalCompleted = LocalDatabase.instance.getHighestCompletedLevel();
    if (totalCompleted <= AppConstants.skipAdsForFirstNLevels) return false;

    // Hourly cap
    _pruneOldTimestamps();
    if (_adTimestamps.length >= AppConstants.maxInterstitialsPerHour) return false;

    final now = DateTime.now();
    final secondsSince = now.difference(_lastAdShownAt).inSeconds;

    // Condition A: ≥3 levels + ≥2 min
    final condA = _levelsSinceLastAd >= AppConstants.minLevelsBetweenAds &&
        secondsSince >= AppConstants.minSecondsBetweenAdsShort;

    // Condition B: ≥4 min (any level count)
    final condB = secondsSince >= AppConstants.minSecondsBetweenAdsLong;

    return condA || condB;
  }

  /// Show interstitial ad. Returns true if shown.
  Future<bool> showInterstitial() async {
    if (kIsWeb) {
      debugPrint('AdService: (Web Mock) Showing Interstitial... Done.');
      _recordAdShown();
      return true;
    }

    if (_interstitialAd == null) {
      _preloadInterstitial();
      return false;
    }

    final completer = Completer<bool>();

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _interstitialAd = null;
        _preloadInterstitial();
        completer.complete(true);
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('Interstitial show failed: ${error.message}');
        ad.dispose();
        _interstitialAd = null;
        _preloadInterstitial();
        completer.complete(false);
      },
    );

    await _interstitialAd!.show();
    _recordAdShown();
    return completer.future;
  }

  /// Show interstitial if conditions are met. Call on level complete.
  Future<bool> showInterstitialIfReady() async {
    if (!shouldShowInterstitial()) return false;
    return showInterstitial();
  }

  // ==========  REWARDED  ==========

  void _preloadRewarded() {
    if (!_shouldShowAds()) return;

    RewardedAd.load(
      adUnitId: AppConstants.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          debugPrint('AdService: Rewarded preloaded');
        },
        onAdFailedToLoad: (error) {
          debugPrint('AdService: Rewarded preload failed: ${error.message}');
          _rewardedAd = null;
        },
      ),
    );
  }

  bool get isRewardedReady => (kIsWeb && _shouldShowAds()) || (_rewardedAd != null && _shouldShowAds());

  /// Show rewarded ad. Returns true if user earned reward.
  Future<bool> showRewarded() async {
    if (kIsWeb) {
      debugPrint('AdService: (Web Mock) Showing Rewarded... Done.');
      return true;
    }

    if (_rewardedAd == null) {
      _preloadRewarded();
      return false;
    }

    final completer = Completer<bool>();
    bool rewarded = false;

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _rewardedAd = null;
        _preloadRewarded();
        completer.complete(rewarded);
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('Rewarded show failed: ${error.message}');
        ad.dispose();
        _rewardedAd = null;
        _preloadRewarded();
        completer.complete(false);
      },
    );

    await _rewardedAd!.show(
      onUserEarnedReward: (_, reward) {
        rewarded = true;
      },
    );

    return completer.future;
  }

  // ==========  HELPERS  ==========

  bool _shouldShowAds() {
    return AppConstants.adsEnabled && _isInitialized && !isPro;
  }

  void _recordAdShown() {
    _lastAdShownAt = DateTime.now();
    _levelsSinceLastAd = 0;
    _adTimestamps.add(DateTime.now());
  }

  void _pruneOldTimestamps() {
    final oneHourAgo = DateTime.now().subtract(const Duration(hours: 1));
    _adTimestamps.removeWhere((t) => t.isBefore(oneHourAgo));
  }

  void dispose() {
    _interstitialAd?.dispose();
    _bannerAd?.dispose();
    _rewardedAd?.dispose();
  }
}
