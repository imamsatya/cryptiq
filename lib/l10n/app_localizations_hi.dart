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
  String get statistics => 'आँकड़े';

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
  String get clear => 'मिटाएँ';

  @override
  String get clearAll => 'सब मिटाएँ';

  @override
  String get congratulations => 'बधाई!';

  @override
  String get puzzleSolved => 'पहेली हल!';

  @override
  String get nextLevel => 'अगला स्तर';

  @override
  String get replay => 'फिर खेलें';

  @override
  String get share => 'साझा करें';

  @override
  String get time => 'समय';

  @override
  String get hints => 'संकेत';

  @override
  String get allowHints => 'Allow Hints';

  @override
  String get bestTime => 'सर्वश्रेष्ठ समय';

  @override
  String levelsCompleted(int count, int total) {
    return '$count/$total पूर्ण';
  }

  @override
  String get totalTime => 'कुल समय';

  @override
  String get averageTime => 'औसत';

  @override
  String get hintsUsed => 'उपयोग किए गए संकेत';

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
  String get about => 'के बारे में';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get rateApp => 'ऐप रेट करें';

  @override
  String get removeAds => 'विज्ञापन हटाएँ';

  @override
  String get restorePurchase => 'खरीद पुनर्स्थापित करें';

  @override
  String get tryAgain => 'पुनः प्रयास करें';

  @override
  String get wrongAnswer => 'गलत उत्तर';

  @override
  String get someDigitsWrong => 'कुछ अंक गलत हैं। फिर से प्रयास करें!';

  @override
  String get fillAllLetters => 'Please fill all letters first!';

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
    return '$count तारे';
  }

  @override
  String get selectLevel => 'स्तर चुनें';

  @override
  String get badges => 'बैज';

  @override
  String get passAndPlay => 'पास एंड प्ले (2-4)';

  @override
  String get decodeTheLogic => 'तर्क को डिकोड करें';

  @override
  String continueLevel(int number) {
    return 'जारी रखें (स्तर $number)';
  }

  @override
  String get selectDifficulty => 'कठिनाई चुनें';

  @override
  String get all => 'सभी';

  @override
  String get completed => 'पूर्ण';

  @override
  String get locked => 'लॉक';

  @override
  String get unlocked => 'अनलॉक';

  @override
  String get theme => 'थीम';

  @override
  String get replayTutorial => 'ट्यूटोरियल देखें';

  @override
  String get version => 'संस्करण';

  @override
  String get contactUs => 'हमसे संपर्क करें';

  @override
  String get resetProgress => 'प्रगति रीसेट करें';

  @override
  String get correct => 'सही!';

  @override
  String get incorrect => 'गलत';

  @override
  String get round => 'राउंड';

  @override
  String get player => 'खिलाड़ी';

  @override
  String get score => 'स्कोर';

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
  String get solvedIn => 'हल किया';

  @override
  String get seconds => 'सेकंड';

  @override
  String get noHintsUsed => 'बिना संकेत';

  @override
  String get playAgain => 'फिर से खेलें';

  @override
  String get results => 'परिणाम';

  @override
  String get dailyStreak => 'दैनिक श्रृंखला';

  @override
  String get giveUp => 'हार मानें';

  @override
  String get rematch => 'पुनर्मुकाबला';

  @override
  String get achievementUnlocked => 'उपलब्धि अनलॉक!';

  @override
  String get noHintsAvailable => 'इस पहेली के लिए कोई संकेत नहीं';

  @override
  String get overallProgress => 'कुल प्रगति';

  @override
  String roundNumber(int number) {
    return 'राउंड $number';
  }

  @override
  String dayStreak(int count) {
    return '$count दिन की श्रृंखला!';
  }

  @override
  String get shareResult => 'परिणाम साझा करें';

  @override
  String get dailyComplete => 'दैनिक चुनौती पूर्ण!';

  @override
  String get completeMoreLevels => 'दोबारा खेलने के लिए और स्तर पूरे करें';

  @override
  String get viewSolution => 'हल देखें';

  @override
  String get attempts => 'प्रयास';

  @override
  String get close => 'बंद करें';

  @override
  String get game => 'खेल';

  @override
  String get soundEffects => 'ध्वनि प्रभाव';

  @override
  String get hapticFeedback => 'हैप्टिक फीडबैक';

  @override
  String get dailyReminder => 'दैनिक अनुस्मारक';

  @override
  String get appearance => 'दिखावट';

  @override
  String get upgradeToPro => 'Pro में अपग्रेड करें';

  @override
  String get noAds => 'विज्ञापन नहीं';

  @override
  String get allThemes => 'सभी थीम';

  @override
  String get bonusHint => '+1 बोनस संकेत';

  @override
  String get goPro => 'Pro बनें';

  @override
  String get proActive => 'CryptiQ Pro ✓';

  @override
  String get byDifficulty => 'कठिनाई के अनुसार';

  @override
  String get totalStars => 'कुल तारे';

  @override
  String get avgTime => 'औसत समय';

  @override
  String get enjoyingApp => 'CryptiQ पसंद आ रहा है?';

  @override
  String get rateAppBody => 'अगर ऐप पसंद आया, तो कृपया इसे रेट करें!';

  @override
  String get noThanks => 'नहीं, धन्यवाद';

  @override
  String get later => 'बाद में';

  @override
  String get rateNow => 'अभी रेट करें ⭐';

  @override
  String get undo => 'पूर्ववत करें';

  @override
  String get overview => 'अवलोकन';

  @override
  String get dataCollection => 'डेटा संग्रह';

  @override
  String get thirdPartyServices => 'तृतीय-पक्ष सेवाएँ';

  @override
  String get dataStorage => 'डेटा भंडारण';

  @override
  String get childrenPrivacy => 'बच्चों की गोपनीयता';

  @override
  String get changes => 'परिवर्तन';

  @override
  String get contact => 'संपर्क';

  @override
  String get lastUpdated => 'अंतिम अद्यतन';

  @override
  String levelsOf(int completed, int total) {
    return '$total में से $completed स्तर पूर्ण';
  }

  @override
  String get tutorialWelcomeTitle => 'CryptiQ में आपका स्वागत है!';

  @override
  String get tutorialWelcomeBody =>
      'प्रत्येक अक्षर एक अद्वितीय अंक (0-9) को दर्शाता है।\nलक्ष्य: पता लगाएँ कि कौन सा अंक किस अक्षर को दर्शाता है\nताकि समीकरण सही हो।';

  @override
  String get tutorialSelectTitle => 'चरण 1: अक्षर चुनें';

  @override
  String get tutorialSelectBody =>
      'समीकरण में किसी भी अक्षर पर टैप करें।\nयह हाइलाइट होगा जो चयन दर्शाता है।';

  @override
  String get tutorialAssignTitle => 'चरण 2: अंक निर्दिष्ट करें';

  @override
  String get tutorialAssignBody =>
      'नंबर पैड का उपयोग करके चयनित अक्षर को\nअंक (0-9) निर्दिष्ट करें।\nप्रत्येक अंक केवल एक बार उपयोग किया जा सकता है!';

  @override
  String get tutorialCheckTitle => 'चरण 3: उत्तर जाँचें';

  @override
  String get tutorialCheckBody =>
      'जब सभी अक्षरों में अंक हों, \"जाँचें\" टैप करें।\nगलत अक्षर लाल हो जाते हैं — सुधारें!\nअटक जाएँ तो संकेत या पूर्ववत उपयोग करें।';

  @override
  String get tutorialGoTitle => 'आप तैयार हैं!';

  @override
  String get tutorialGoBody =>
      'कम संकेतों से तेज़ी से हल करें ⭐⭐⭐!\nशुभकामनाएँ और मज़े करें! 🧩';

  @override
  String get next => 'अगला';

  @override
  String get autoFillNext => 'अगला अक्षर स्वचालित चुनें';

  @override
  String get onboardingWelcomeTitle => 'CryptiQ में आपका स्वागत है!';

  @override
  String get onboardingWelcomeSubtitle => 'तर्क को डिकोड करें';

  @override
  String get onboardingWelcomeBody =>
      'CryptiQ एक क्रिप्टारिथमेटिक पहेली खेल है जहाँ प्रत्येक अक्षर एक अद्वितीय अंक (0-9) को दर्शाता है।\n\nलक्ष्य: पता लगाएँ कि कौन सा अंक किस अक्षर से मेल खाता है ताकि समीकरण सत्य हो!';

  @override
  String get onboardingHowToPlay => 'कैसे खेलें';

  @override
  String get onboardingSelectAssign => 'चुनें और निर्दिष्ट करें';

  @override
  String get onboardingExample => 'अगर S=9, E=5, N=6, D=7\nतो SEND = 9567';

  @override
  String get onboardingNeedHelp => 'मदद चाहिए?';

  @override
  String get onboardingDailyTitle => 'दैनिक चुनौती';

  @override
  String get onboardingDailySubtitle => 'हर दिन वापस आएँ!';

  @override
  String get onboardingReady => 'तैयार हैं? चलें! 🚀';

  @override
  String get skip => 'छोड़ें';

  @override
  String get startPlaying => 'खेलना शुरू करें';

  @override
  String playerName(int number) {
    return 'खिलाड़ी $number';
  }

  @override
  String get addPlayer => 'खिलाड़ी जोड़ें';

  @override
  String roundsLabel(int count) {
    return 'राउंड: $count';
  }

  @override
  String get addition => 'जोड़ (+)';

  @override
  String get subtraction => 'घटाव (−)';

  @override
  String get multiply => 'गुणा (×)';

  @override
  String get multiStep => 'बहु-चरण';

  @override
  String get passDevice => 'इस खिलाड़ी को डिवाइस दें';

  @override
  String get roundDetails => 'राउंड विवरण';

  @override
  String get gaveUp => 'हार मान ली';

  @override
  String get beatMyTime => 'क्या आप मेरा समय हरा सकते हैं?';

  @override
  String get allLevelsFreeTitle => 'सभी 1200 स्तर मुफ़्त';

  @override
  String get allLevelsFreeBody => 'कोई लॉक स्तर नहीं। आनंद लें!';

  @override
  String get privacyOverviewBody =>
      'हम आपकी गोपनीयता का सम्मान करते हैं और आपकी व्यक्तिगत जानकारी की सुरक्षा के लिए प्रतिबद्ध हैं।';

  @override
  String get privacyDataBody =>
      'सभी गेम प्रगति ऑफ़लाइन स्टोरेज (Hive) का उपयोग करके आपके डिवाइस पर स्थानीय रूप से संग्रहीत होती है। हमें खाता बनाने या लॉगिन की आवश्यकता नहीं है।';

  @override
  String get privacyStorageBody =>
      'सभी डेटा (प्रगति, सेटिंग्स, उपलब्धियाँ) स्थानीय रूप से संग्रहीत होते हैं। ऐप अनइंस्टॉल करने से सभी स्थानीय डेटा हट जाएगा।';

  @override
  String get privacyChangesBody =>
      'हम इस नीति को अपडेट कर सकते हैं। परिवर्तनों के बाद निरंतर उपयोग स्वीकृति माना जाएगा।';

  @override
  String privacyContactBody(String email) {
    return 'प्रश्नों के लिए, ईमेल: $email';
  }

  @override
  String get multiStepLabel => 'बहु-चरण';

  @override
  String get stars3 => 'तारे';

  @override
  String get onboardingHowToPlayBody =>
      '1. अक्षर पर टैप करके चुनें\n2. नंबर (0-9) पर टैप करके निर्दिष्ट करें\n3. प्रत्येक अक्षर का अद्वितीय अंक होना चाहिए\n4. अक्षर को लंबे समय तक दबाकर मिटाएँ';

  @override
  String get onboardingHelpSubtitle => 'संकेत और जाँच';

  @override
  String get onboardingHelpBody =>
      '• 💡 संकेत टैप करके अक्षर प्रकट करें\n• ✓ जाँचें टैप करके चेक करें\n• गलत अक्षर लाल, सही हरे होते हैं\n• कम संकेतों से हल करें ज़्यादा ⭐!';

  @override
  String get onboardingDailyBody =>
      '• हर दिन एक नई पहेली\n• रोज़ खेलकर श्रृंखला 🔥 बनाएँ\n• खेलते हुए उपलब्धियाँ अनलॉक करें\n• आसान से विशेषज्ञ तक 1200 स्तर — सब मुफ़्त!';

  @override
  String get onboardingStarExample =>
      '⭐⭐⭐  बिना संकेत, तेज़\n⭐⭐     1-2 संकेत\n⭐       3+ संकेत';

  @override
  String usedBy(String letter) {
    return 'उपयोगकर्ता: $letter';
  }

  @override
  String get notUsed => 'अनुपयोगी';

  @override
  String get replayConfirmTitle => 'यह स्तर फिर खेलें?';

  @override
  String get replayConfirmBody =>
      'इस स्तर पर पहले से ⭐⭐⭐ है। सर्वश्रेष्ठ स्कोर बना रहेगा।';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get newBadge => 'नया';

  @override
  String get themePicker => 'थीम';

  @override
  String get proThemeHint => 'Pro से और थीम अनलॉक करें';

  @override
  String get shareStats => 'आँकड़े साझा करें';

  @override
  String get updateAvailable => 'अपडेट उपलब्ध';

  @override
  String get updateBody =>
      'CryptiQ का नया संस्करण उपलब्ध है। सर्वश्रेष्ठ अनुभव के लिए अभी अपडेट करें!';

  @override
  String get updateNow => 'अभी अपडेट करें';

  @override
  String get puzzlesSolved => 'हल की गई पहेलियाँ';

  @override
  String get allDone => 'सब हो गया!';

  @override
  String hintCount(int count) {
    return 'संकेत ($count)';
  }

  @override
  String get incorrectTryAgain => 'गलत — फिर से प्रयास करें!';

  @override
  String playerScored(String player, int score) {
    return '$player ने $score अंक प्राप्त किए';
  }

  @override
  String hintsCount(int count) {
    return '$count संकेत';
  }

  @override
  String roundOf(int current, int total) {
    return 'राउंड $current/$total';
  }

  @override
  String get imReady => 'मैं तैयार हूँ!';

  @override
  String playerWins(String player) {
    return '$player जीता!';
  }

  @override
  String playerStatsLine(int solved, int total, String time, int hints) {
    return '$solved/$total हल • $time • $hints संकेत';
  }

  @override
  String scorePts(int score) {
    return '$scoreअंक';
  }

  @override
  String get playerNameHint => 'खिलाड़ी का नाम';

  @override
  String get multiStepNote =>
      'बहु-चरण पहेलियाँ केवल कठिन/विशेषज्ञ हैं। कठिनाई अनदेखी होगी।';

  @override
  String percentUnlocked(String percent) {
    return '$percent% अनलॉक';
  }

  @override
  String shareDailyText(String time, int streak) {
    return 'मैंने CryptiQ की दैनिक चुनौती $time में हल की! 🔥 $streak दिन की श्रृंखला! क्या आप हरा सकते हैं?\n\n#CryptiQ #दैनिकचुनौती';
  }

  @override
  String get achvNoHints10Title => 'तेज दिमाग';

  @override
  String get achvStreak30Title => 'स्ट्रीक मास्टर';

  @override
  String get achvStreak14Desc => '14 दिन की दैनिक चुनौती श्रृंखला';

  @override
  String get achvPerfect50Desc => '50 स्तरों पर 3 स्टार प्राप्त करें';

  @override
  String get achvFiveHundredLevelsTitle => 'आधे रास्ते वहाँ';

  @override
  String get achvExpertMasterTitle => 'विशेषज्ञ क्रिप्टोग्राफर';

  @override
  String get achvLightningDesc =>
      'किसी पहेली को 10 सेकंड से कम समय में हल करें';

  @override
  String get achvFirstSolveDesc => 'अपनी पहली पहेली हल करें';

  @override
  String get achvExpertMasterDesc => 'सभी विशेषज्ञ स्तरों को पूरा करें';

  @override
  String get achvPerfect50Title => 'बेदाग';

  @override
  String get achvHundredLevelsDesc => '100 स्तर पूरे करें';

  @override
  String get achvHundredStarsDesc => '100 सितारे अर्जित करें';

  @override
  String get achvHardMasterDesc => 'सभी कठिन स्तरों को पूरा करें';

  @override
  String get achvHundredStarsTitle => 'स्टार हंटर';

  @override
  String get achvStreak14Title => 'दो सप्ताह का चैंपियन';

  @override
  String get achvPerfect10Desc => '10 स्तरों पर 3 स्टार प्राप्त करें';

  @override
  String get achvHundredLevelsTitle => 'सूबेदार';

  @override
  String get achvHardMasterTitle => 'कठोर';

  @override
  String get achvLightningTitle => 'बिजली की तेजी';

  @override
  String get achvTenStarsDesc => '10 स्टार कमाएँ';

  @override
  String get achvFirstSolveTitle => 'पहले कदम';

  @override
  String get achvStreak7Desc => '7 दिन की दैनिक चुनौती श्रृंखला';

  @override
  String get achvPerfect10Title => 'पूर्णतावादी';

  @override
  String get achvMediumMasterDesc => 'सभी मध्यम स्तरों को पूरा करें';

  @override
  String get achvSpeedDemonDesc => '15 सेकंड से कम समय में पहेली हल करें';

  @override
  String get achvTenStarsTitle => 'स्टार कलेक्टर';

  @override
  String get achvFiftyLevelsDesc => '50 स्तर पूरे करें';

  @override
  String get achvStreak7Title => 'सप्ताह योद्धा';

  @override
  String get achvNoHints50Desc => 'बिना संकेत के 50 पहेलियाँ हल करें';

  @override
  String get achvMediumMasterTitle => 'दुर्लभ माध्यम';

  @override
  String get achvSpeedDemonTitle => 'गति दानव';

  @override
  String get achvThousandLevelsDesc => '1000 स्तर पूरे करें';

  @override
  String get achvFiftyLevelsTitle => 'पहेली उत्साही';

  @override
  String get achvNoHints50Title => 'शुद्ध प्रतिभा';

  @override
  String get achvThousandStarsDesc => '1000 सितारे अर्जित करें';

  @override
  String get achvThousandLevelsTitle => 'ग्रैंड मास्टर';

  @override
  String get achvStreak3Desc => '3 दिन की दैनिक चुनौती श्रृंखला';

  @override
  String get achvEasyMasterDesc => 'सभी आसान स्तरों को पूरा करें';

  @override
  String get achvNoHints10Desc => 'बिना संकेत के 10 पहेलियाँ हल करें';

  @override
  String get achvStreak100Title => 'रुक';

  @override
  String get achvStreak3Title => 'एक रोल पर';

  @override
  String get achvThousandStarsTitle => 'तारामंडल';

  @override
  String get achvTenLevelsTitle => 'गर्म होना';

  @override
  String get achvEasyMasterTitle => 'आसान मटर';

  @override
  String get achvTenLevelsDesc => '10 स्तर पूरे करें';

  @override
  String get achvStreak30Desc => '30 दिन की दैनिक चुनौती श्रृंखला';

  @override
  String get achvFiveHundredLevelsDesc => '500 स्तर पूरे करें';

  @override
  String get achvStreak100Desc => '100 दिन की दैनिक चुनौती श्रृंखला';

  @override
  String get achvMultiStepFirstTitle => 'श्रृंखला अभिक्रिया';

  @override
  String get achvMultiStepFirstDesc => 'अपनी पहली बहु-चरणीय पहेली को हल करें';

  @override
  String get achvMultiStepAllDesc => 'सभी 200 बहु-चरणीय पहेलियाँ पूरी करें';

  @override
  String get achvMultiStepAllTitle => 'कैस्केड किंग';
}
