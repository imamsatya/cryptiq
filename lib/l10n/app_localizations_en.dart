// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'CryptiQ';

  @override
  String get play => 'Play';

  @override
  String get dailyChallenge => 'Daily Challenge';

  @override
  String get statistics => 'Statistics';

  @override
  String get settings => 'Settings';

  @override
  String level(int number) {
    return 'Level $number';
  }

  @override
  String get easy => 'Easy';

  @override
  String get medium => 'Medium';

  @override
  String get hard => 'Hard';

  @override
  String get expert => 'Expert';

  @override
  String get hint => 'Hint';

  @override
  String get check => 'Check';

  @override
  String get clear => 'Clear';

  @override
  String get clearAll => 'Clear All';

  @override
  String get congratulations => 'Congratulations!';

  @override
  String get puzzleSolved => 'Puzzle Solved!';

  @override
  String get nextLevel => 'Next Level';

  @override
  String get replay => 'Replay';

  @override
  String get share => 'Share';

  @override
  String get time => 'Time';

  @override
  String get hints => 'Hints';

  @override
  String get bestTime => 'Best Time';

  @override
  String get levelsCompleted => 'Levels Completed';

  @override
  String get totalTime => 'Total Time';

  @override
  String get averageTime => 'Average Time';

  @override
  String get hintsUsed => 'Hints Used';

  @override
  String get currentStreak => 'Current Streak';

  @override
  String get bestStreak => 'Best Streak';

  @override
  String get sound => 'Sound';

  @override
  String get haptics => 'Haptics';

  @override
  String get language => 'Language';

  @override
  String get about => 'About';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get rateApp => 'Rate App';

  @override
  String get removeAds => 'Remove Ads';

  @override
  String get restorePurchase => 'Restore Purchase';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get wrongAnswer => 'Wrong Answer';

  @override
  String get someDigitsWrong => 'Some digits are incorrect. Try again!';

  @override
  String get allLevelsFree => 'All levels are FREE!';

  @override
  String get noLockedLevels => 'No locked levels, ever.';

  @override
  String get home => 'Home';

  @override
  String get back => 'Back';

  @override
  String get resume => 'Resume';

  @override
  String stars(int count) {
    return '$count Stars';
  }
}
