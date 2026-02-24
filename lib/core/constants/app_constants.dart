/// Application-wide constants
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'CryptiQ';
  static const String appVersion = '1.0.0';
  static const String packageName = 'com.cryptiq.app';
  static const String contactEmail = 'cryptiq.app@gmail.com';

  // Game Config
  static const int totalLevels = 500;
  static const int easyLevels = 100;       // Levels 1-100
  static const int mediumLevels = 150;     // Levels 101-250
  static const int hardLevels = 150;       // Levels 251-400
  static const int expertLevels = 100;     // Levels 401-500

  // Hints
  static const int initialFreeHints = 5;
  static const int hintsPerRewardedAd = 2;
  static const int maxHints = 99;

  // Stars Rating
  static const int threeStarMaxHints = 0;  // No hints used
  static const int twoStarMaxHints = 2;    // Up to 2 hints
  // 1 star: more than 2 hints

  // Time thresholds for stars (seconds)
  static const int threeStarMaxTimeEasy = 60;
  static const int threeStarMaxTimeMedium = 120;
  static const int threeStarMaxTimeHard = 180;
  static const int threeStarMaxTimeExpert = 300;

  // Ads
  static const bool adsEnabled = false;  // Disable until AdMob is set up
  static const int interstitialAdInterval = 5; // Every 5 levels

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

  // IAP Product IDs
  static const String proProductId = 'cryptiq_pro';
}
