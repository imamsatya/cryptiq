import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for hi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([super.locale = 'hi']);

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
    return 'स्तर {number}';
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
  String get bestTime => 'सर्वश्रेष्ठ समय';

  @override
  String get levelsCompleted => 'पूरे स्तर';

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
  String get about => 'परिचय';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

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
    return '{count} सितारे';
  }

}
