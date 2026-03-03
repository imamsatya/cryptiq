// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'CryptiQ';

  @override
  String get play => 'खेलें';

  @override
  String get dailyChallenge => 'दैनिक चुनौती';

  @override
  String get statistics => 'आंकड़े';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String level(int number) {
    return 'स्तर $number';
  }

  @override
  String get easy => 'आसान';

  @override
  String get medium => 'मध्यम';

  @override
  String get hard => 'कठिन';

  @override
  String get expert => 'विशेषज्ञ';

  @override
  String get hint => 'संकेत';

  @override
  String get check => 'जाँचें';

  @override
  String get clear => 'मिटाएं';

  @override
  String get clearAll => 'सब मिटाएं';

  @override
  String get congratulations => 'बधाई हो!';

  @override
  String get puzzleSolved => 'पहेली हल!';

  @override
  String get nextLevel => 'अगला स्तर';

  @override
  String get replay => 'फिर से खेलें';

  @override
  String get share => 'साझा करें';

  @override
  String get time => 'समय';

  @override
  String get hints => 'संकेत';

  @override
  String get bestTime => 'सर्वोत्तम समय';

  @override
  String get levelsCompleted => 'पूर्ण स्तर';

  @override
  String get totalTime => 'कुल समय';

  @override
  String get averageTime => 'औसत समय';

  @override
  String get hintsUsed => 'संकेत उपयोग';

  @override
  String get currentStreak => 'वर्तमान श्रृंखला';

  @override
  String get bestStreak => 'सर्वश्रेष्ठ श्रृंखला';

  @override
  String get sound => 'ध्वनि';

  @override
  String get haptics => 'कंपन';

  @override
  String get language => 'भाषा';

  @override
  String get about => 'बारे में';

  @override
  String get privacyPolicy => 'गोपनीयता';

  @override
  String get rateApp => 'ऐप रेट करें';

  @override
  String get removeAds => 'विज्ञापन हटाएं';

  @override
  String get restorePurchase => 'खरीदारी पुनर्स्थापित';

  @override
  String get tryAgain => 'पुनः प्रयास';

  @override
  String get wrongAnswer => 'गलत उत्तर';

  @override
  String get someDigitsWrong => 'कुछ अंक गलत हैं। पुनः प्रयास करें!';

  @override
  String get allLevelsFree => 'सभी स्तर मुफ़्त!';

  @override
  String get noLockedLevels => 'कोई लॉक स्तर नहीं।';

  @override
  String get home => 'होम';

  @override
  String get back => 'वापस';

  @override
  String get resume => 'जारी रखें';

  @override
  String stars(int count) {
    return '$count सितारे';
  }

  @override
  String get selectLevel => 'स्तर चुनें';

  @override
  String get badges => 'बैज';

  @override
  String get passAndPlay => 'बारी-बारी खेलें (2-4)';

  @override
  String get decodeTheLogic => 'तर्क को सुलझाएं';

  @override
  String continueLevel(int number) {
    return 'जारी रखें (स्तर $number)';
  }

  @override
  String get selectDifficulty => 'कठिनाई चुनें';

  @override
  String get all => 'सभी';

  @override
  String get completed => 'पूरा';

  @override
  String get locked => 'लॉक';

  @override
  String get unlocked => 'अनलॉक';

  @override
  String get theme => 'थीम';

  @override
  String get replayTutorial => 'ट्यूटोरियल';

  @override
  String get version => 'संस्करण';

  @override
  String get contactUs => 'संपर्क';

  @override
  String get resetProgress => 'रीसेट';

  @override
  String get correct => 'सही!';

  @override
  String get incorrect => 'गलत';

  @override
  String get round => 'राउंड';

  @override
  String get player => 'खिलाड़ी';

  @override
  String get score => 'अंक';

  @override
  String get winner => 'विजेता';

  @override
  String get draw => 'ड्रॉ';

  @override
  String get players => 'खिलाड़ी';

  @override
  String get rounds => 'राउंड';

  @override
  String get difficulty => 'कठिनाई';

  @override
  String get operation => 'संक्रिया';

  @override
  String get mixed => 'मिश्रित';

  @override
  String get startGame => 'शुरू';

  @override
  String get achievements => 'उपलब्धियाँ';

  @override
  String get streak => 'श्रृंखला';

  @override
  String get solvedIn => 'समय में हल';

  @override
  String get seconds => 'सेकंड';

  @override
  String get noHintsUsed => 'बिना संकेत';

  @override
  String get playAgain => 'फिर खेलें';

  @override
  String get results => 'परिणाम';

  @override
  String get dailyStreak => 'दैनिक श्रृंखला';

  @override
  String get giveUp => 'हार मानें';

  @override
  String get rematch => 'दोबारा खेलें';

  @override
  String get achievementUnlocked => 'उपलब्धि खुली!';

  @override
  String get noHintsAvailable => 'कोई संकेत नहीं बचा';

  @override
  String get overallProgress => 'कुल प्रगति';

  @override
  String roundNumber(int number) {
    return 'राउंड $number';
  }

  @override
  String dayStreak(int count) {
    return '$count दिन लगातार!';
  }

  @override
  String get shareResult => 'परिणाम साझा करें';

  @override
  String get dailyComplete => 'दैनिक चुनौती पूरी!';

  @override
  String get completeMoreLevels => 'फिर से खेलने के लिए अधिक स्तर पूरे करें';

  @override
  String get viewSolution => 'उत्तर देखें';

  @override
  String get attempts => 'प्रयास';

  @override
  String get close => 'बंद करें';

  @override
  String get game => 'Game';

  @override
  String get soundEffects => 'Sound Effects';

  @override
  String get hapticFeedback => 'Haptic Feedback';

  @override
  String get dailyReminder => 'Daily Reminder';

  @override
  String get appearance => 'Appearance';

  @override
  String get upgradeToPro => 'Upgrade to Pro';

  @override
  String get noAds => 'No Ads';

  @override
  String get allThemes => 'All Themes';

  @override
  String get bonusHint => '+1 Bonus Hint';

  @override
  String get goPro => 'Go Pro';

  @override
  String get proActive => 'CryptiQ Pro ✓';

  @override
  String get byDifficulty => 'By Difficulty';

  @override
  String get totalStars => 'Total Stars';

  @override
  String get avgTime => 'Avg. Time';

  @override
  String get enjoyingApp => 'Enjoying CryptiQ?';

  @override
  String get rateAppBody =>
      'If you like the app, please take a moment to rate it!';

  @override
  String get noThanks => 'No Thanks';

  @override
  String get later => 'Later';

  @override
  String get rateNow => 'Rate Now ⭐';

  @override
  String get undo => 'Undo';

  @override
  String get overview => 'Overview';

  @override
  String get dataCollection => 'Data Collection';

  @override
  String get thirdPartyServices => 'Third-Party Services';

  @override
  String get dataStorage => 'Data Storage';

  @override
  String get childrenPrivacy => 'Children\'s Privacy';

  @override
  String get changes => 'Changes';

  @override
  String get contact => 'Contact';

  @override
  String get lastUpdated => 'Last Updated';

  @override
  String levelsOf(int completed, int total) {
    return '$completed of $total levels completed';
  }

  @override
  String get tutorialWelcomeTitle => 'Welcome to CryptiQ!';

  @override
  String get tutorialWelcomeBody =>
      'Each letter represents a unique digit (0-9).\nYour goal: find which digit each letter stands for\nso the equation is correct.';

  @override
  String get tutorialSelectTitle => 'Step 1: Select a Letter';

  @override
  String get tutorialSelectBody =>
      'Tap on any letter tile in the equation.\nIt will highlight, showing it\'s selected.';

  @override
  String get tutorialAssignTitle => 'Step 2: Assign a Digit';

  @override
  String get tutorialAssignBody =>
      'Use the number pad to assign a digit (0-9)\nto the selected letter.\nEach digit can only be used once!';

  @override
  String get tutorialCheckTitle => 'Step 3: Check Your Answer';

  @override
  String get tutorialCheckBody =>
      'Once all letters have digits, tap \"Check\".\nWrong letters turn red — fix them!\nUse Hints or Undo if you get stuck.';

  @override
  String get tutorialGoTitle => 'You\'re Ready!';

  @override
  String get tutorialGoBody =>
      'Solve fast with fewer hints for ⭐⭐⭐!\nGood luck and have fun! 🧩';

  @override
  String get next => 'Next';

  @override
  String get autoFillNext => 'Auto-select Next Letter';
}
