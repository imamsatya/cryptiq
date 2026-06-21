/// Application-wide constants
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'CryptiQ';
  static const String appVersion = '1.0.0';
  static const String packageName = 'com.cryptiq.app';
  static const String contactEmail = 'cryptiq.app@gmail.com';

  // ⚡ Developer Mode — set to false before production/Play Store release!
  static const bool devProMode = true;  // Forces Pro status ON for testing

  // Game Config
  static const int totalLevels = 1200;
  static const int easyLevels = 250;       // Levels 1-250
  static const int mediumLevels = 250;     // Levels 251-500
  static const int hardLevels = 250;       // Levels 501-750
  static const int expertLevels = 450;     // Levels 751-1200 (incl. multi-step)

  // Hints (per-puzzle, based on letter count)
  static const double hintPercentage = 0.30;    // 30% of hidden letters (base)
  static const int minLettersForHint = 3;       // Need at least 3 letters for 1 hint

  // Stars Rating
  static const int threeStarMaxHints = 0;  // No hints used
  static const int twoStarMaxHints = 2;    // Up to 2 hints
  // 1 star: more than 2 hints

  // Time thresholds for stars (seconds)
  static const int threeStarMaxTimeEasy = 60;
  static const int threeStarMaxTimeMedium = 120;
  static const int threeStarMaxTimeHard = 180;
  static const int threeStarMaxTimeExpert = 300;

  // Ads — Interstitial trigger (OR logic)
  static const bool adsEnabled = true;  // Test ads are enabled for release testing
  static const int minLevelsBetweenAds = 3;         // Condition A: min levels
  static const int minSecondsBetweenAdsShort = 120;  // Condition A: min 2 min
  static const int minSecondsBetweenAdsLong = 240;   // Condition B: 4 min auto-trigger
  static const int maxInterstitialsPerHour = 8;      // Safety cap
  static const int skipAdsForFirstNLevels = 5;       // No ads for first 5 levels

  // Ad Unit IDs (replace with real IDs before release)
  static const String bannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';         // TEST
  static const String interstitialAdUnitId = 'ca-app-pub-3940256099942544/1033173712';   // TEST
  static const String rewardedAdUnitId = 'ca-app-pub-3940256099942544/5224354917';       // TEST

  // Hive Box Names
  static const String progressBox = 'user_progress';
  static const String settingsBox = 'settings';
  static const String statsBox = 'game_stats';

  // Settings Keys
  static const String soundKey = 'sound_enabled';
  static const String hapticsKey = 'haptics_enabled';
  static const String localeKey = 'selected_locale';
  static const String proStatusKey = 'is_pro';
  static const String hintBalanceKey = 'hint_balance';
  static const String lastPlayedLevelKey = 'last_played_level';
  static const String notificationKey = 'notifications_enabled';
  static const int notificationHour = 19; // 7 PM daily reminder
  static const String rateAppKey = 'rate_app_status'; // 'none', 'later', 'never', 'rated'
  static const int rateAppAfterLevels = 10; // Show after completing 10 levels

  // IAP Product IDs
  static const String proProductId = 'cryptiq_pro';
  static const double proPrice = 2.99;
}
