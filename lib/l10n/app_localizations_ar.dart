// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'CryptiQ';

  @override
  String get play => 'العب';

  @override
  String get dailyChallenge => 'التحدي اليومي';

  @override
  String get statistics => 'الإحصائيات';

  @override
  String get settings => 'الإعدادات';

  @override
  String level(int number) {
    return 'المستوى $number';
  }

  @override
  String get easy => 'سهل';

  @override
  String get medium => 'متوسط';

  @override
  String get hard => 'صعب';

  @override
  String get expert => 'خبير';

  @override
  String get hint => 'تلميح';

  @override
  String get check => 'تحقق';

  @override
  String get clear => 'مسح';

  @override
  String get clearAll => 'مسح الكل';

  @override
  String get congratulations => 'تهانينا!';

  @override
  String get puzzleSolved => 'تم حل اللغز!';

  @override
  String get nextLevel => 'المستوى التالي';

  @override
  String get replay => 'إعادة';

  @override
  String get share => 'مشاركة';

  @override
  String get time => 'الوقت';

  @override
  String get hints => 'تلميحات';

  @override
  String get bestTime => 'أفضل وقت';

  @override
  String levelsCompleted(int count, int total) {
    return '$count/$total مكتمل';
  }

  @override
  String get totalTime => 'الوقت الكلي';

  @override
  String get averageTime => 'المتوسط';

  @override
  String get hintsUsed => 'التلميحات المستخدمة';

  @override
  String get currentStreak => 'السلسلة الحالية';

  @override
  String get bestStreak => 'أفضل سلسلة';

  @override
  String get sound => 'الصوت';

  @override
  String get haptics => 'الاهتزاز';

  @override
  String get language => 'اللغة';

  @override
  String get about => 'حول';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get rateApp => 'قيّم التطبيق';

  @override
  String get removeAds => 'إزالة الإعلانات';

  @override
  String get restorePurchase => 'استعادة الشراء';

  @override
  String get tryAgain => 'حاول مجدداً';

  @override
  String get wrongAnswer => 'إجابة خاطئة';

  @override
  String get someDigitsWrong => 'بعض الأرقام خاطئة. حاول مجدداً!';

  @override
  String get allLevelsFree => 'جميع المستويات مجانية!';

  @override
  String get noLockedLevels => 'لا مستويات مقفلة، أبداً.';

  @override
  String get home => 'الرئيسية';

  @override
  String get back => 'رجوع';

  @override
  String get resume => 'استئناف';

  @override
  String stars(int count) {
    return '$count نجوم';
  }

  @override
  String get selectLevel => 'اختر المستوى';

  @override
  String get badges => 'الشارات';

  @override
  String get passAndPlay => 'مرر والعب (2-4)';

  @override
  String get decodeTheLogic => 'فك شفرة المنطق';

  @override
  String continueLevel(int number) {
    return 'متابعة (المستوى $number)';
  }

  @override
  String get selectDifficulty => 'اختر الصعوبة';

  @override
  String get all => 'الكل';

  @override
  String get completed => 'مكتمل';

  @override
  String get locked => 'مقفل';

  @override
  String get unlocked => 'مفتوح';

  @override
  String get theme => 'السمة';

  @override
  String get replayTutorial => 'إعادة الدرس';

  @override
  String get version => 'الإصدار';

  @override
  String get contactUs => 'اتصل بنا';

  @override
  String get resetProgress => 'إعادة التقدم';

  @override
  String get correct => 'صحيح!';

  @override
  String get incorrect => 'خطأ';

  @override
  String get round => 'الجولة';

  @override
  String get player => 'اللاعب';

  @override
  String get score => 'النتيجة';

  @override
  String get winner => 'الفائز';

  @override
  String get draw => 'تعادل';

  @override
  String get players => 'اللاعبون';

  @override
  String get rounds => 'الجولات';

  @override
  String get difficulty => 'الصعوبة';

  @override
  String get operation => 'العملية';

  @override
  String get mixed => 'مختلط';

  @override
  String get startGame => 'ابدأ';

  @override
  String get achievements => 'الإنجازات';

  @override
  String get streak => 'السلسلة';

  @override
  String get solvedIn => 'تم الحل في';

  @override
  String get seconds => 'ثوانٍ';

  @override
  String get noHintsUsed => 'بدون تلميحات';

  @override
  String get playAgain => 'العب مجدداً';

  @override
  String get results => 'النتائج';

  @override
  String get dailyStreak => 'السلسلة اليومية';

  @override
  String get giveUp => 'استسلام';

  @override
  String get rematch => 'إعادة المباراة';

  @override
  String get achievementUnlocked => 'تم فتح الإنجاز!';

  @override
  String get noHintsAvailable => 'لا تلميحات لهذا اللغز';

  @override
  String get overallProgress => 'التقدم العام';

  @override
  String roundNumber(int number) {
    return 'الجولة $number';
  }

  @override
  String dayStreak(int count) {
    return 'سلسلة $count يوم!';
  }

  @override
  String get shareResult => 'مشاركة النتيجة';

  @override
  String get dailyComplete => 'التحدي اليومي مكتمل!';

  @override
  String get completeMoreLevels => 'أكمل المزيد من المستويات للإعادة';

  @override
  String get viewSolution => 'عرض الحل';

  @override
  String get attempts => 'المحاولات';

  @override
  String get close => 'إغلاق';

  @override
  String get game => 'اللعبة';

  @override
  String get soundEffects => 'المؤثرات الصوتية';

  @override
  String get hapticFeedback => 'التغذية اللمسية';

  @override
  String get dailyReminder => 'التذكير اليومي';

  @override
  String get appearance => 'المظهر';

  @override
  String get upgradeToPro => 'الترقية إلى Pro';

  @override
  String get noAds => 'بدون إعلانات';

  @override
  String get allThemes => 'جميع السمات';

  @override
  String get bonusHint => '+1 تلميح إضافي';

  @override
  String get goPro => 'انتقل إلى Pro';

  @override
  String get proActive => 'CryptiQ Pro ✓';

  @override
  String get byDifficulty => 'حسب الصعوبة';

  @override
  String get totalStars => 'إجمالي النجوم';

  @override
  String get avgTime => 'متوسط الوقت';

  @override
  String get enjoyingApp => 'هل تستمتع بـ CryptiQ؟';

  @override
  String get rateAppBody => 'إذا أعجبك التطبيق، خذ لحظة لتقييمه!';

  @override
  String get noThanks => 'لا، شكراً';

  @override
  String get later => 'لاحقاً';

  @override
  String get rateNow => 'قيّم الآن ⭐';

  @override
  String get undo => 'تراجع';

  @override
  String get overview => 'نظرة عامة';

  @override
  String get dataCollection => 'جمع البيانات';

  @override
  String get thirdPartyServices => 'خدمات الطرف الثالث';

  @override
  String get dataStorage => 'تخزين البيانات';

  @override
  String get childrenPrivacy => 'خصوصية الأطفال';

  @override
  String get changes => 'التغييرات';

  @override
  String get contact => 'الاتصال';

  @override
  String get lastUpdated => 'آخر تحديث';

  @override
  String levelsOf(int completed, int total) {
    return '$completed من $total مستوى مكتمل';
  }

  @override
  String get tutorialWelcomeTitle => 'مرحباً بك في CryptiQ!';

  @override
  String get tutorialWelcomeBody =>
      'كل حرف يمثل رقماً فريداً (0-9).\nهدفك: اكتشف أي رقم يمثل كل حرف\nلتكون المعادلة صحيحة.';

  @override
  String get tutorialSelectTitle => 'الخطوة 1: اختر حرفاً';

  @override
  String get tutorialSelectBody =>
      'انقر على أي حرف في المعادلة.\nسيتم تمييزه ليظهر أنه محدد.';

  @override
  String get tutorialAssignTitle => 'الخطوة 2: خصص رقماً';

  @override
  String get tutorialAssignBody =>
      'استخدم لوحة الأرقام لتخصيص رقم (0-9)\nللحرف المحدد.\nكل رقم يمكن استخدامه مرة واحدة فقط!';

  @override
  String get tutorialCheckTitle => 'الخطوة 3: تحقق من إجابتك';

  @override
  String get tutorialCheckBody =>
      'عندما تكون جميع الحروف بها أرقام، انقر \"تحقق\".\nالحروف الخاطئة تصبح حمراء — صححها!\nاستخدم التلميحات أو التراجع إذا علقت.';

  @override
  String get tutorialGoTitle => 'أنت جاهز!';

  @override
  String get tutorialGoBody =>
      'حل بسرعة مع تلميحات أقل للحصول على ⭐⭐⭐!\nحظاً سعيداً واستمتع! 🧩';

  @override
  String get next => 'التالي';

  @override
  String get autoFillNext => 'اختيار الحرف التالي تلقائياً';

  @override
  String get onboardingWelcomeTitle => 'مرحباً بك في CryptiQ!';

  @override
  String get onboardingWelcomeSubtitle => 'فك شفرة المنطق';

  @override
  String get onboardingWelcomeBody =>
      'CryptiQ هي لعبة ألغاز حسابية مشفرة حيث يمثل كل حرف رقماً فريداً (0-9).\n\nهدفك: اكتشف أي رقم يتوافق مع كل حرف لتصبح المعادلة صحيحة!';

  @override
  String get onboardingHowToPlay => 'كيف تلعب';

  @override
  String get onboardingSelectAssign => 'اختر وخصص';

  @override
  String get onboardingExample => 'إذا S=9, E=5, N=6, D=7\nإذاً SEND = 9567';

  @override
  String get onboardingNeedHelp => 'تحتاج مساعدة؟';

  @override
  String get onboardingDailyTitle => 'التحدي اليومي';

  @override
  String get onboardingDailySubtitle => 'عد كل يوم!';

  @override
  String get onboardingReady => 'جاهز؟ هيا بنا! 🚀';

  @override
  String get skip => 'تخطي';

  @override
  String get startPlaying => 'ابدأ اللعب';

  @override
  String playerName(int number) {
    return 'اللاعب $number';
  }

  @override
  String get addPlayer => 'إضافة لاعب';

  @override
  String roundsLabel(int count) {
    return 'الجولات: $count';
  }

  @override
  String get addition => 'جمع (+)';

  @override
  String get subtraction => 'طرح (−)';

  @override
  String get multiply => 'ضرب (×)';

  @override
  String get multiStep => 'متعدد الخطوات';

  @override
  String get passDevice => 'مرر الجهاز لهذا اللاعب';

  @override
  String get roundDetails => 'تفاصيل الجولة';

  @override
  String get gaveUp => 'استسلم';

  @override
  String get beatMyTime => 'هل يمكنك التغلب على وقتي؟';

  @override
  String get allLevelsFreeTitle => 'جميع 1200 مستوى مجانية';

  @override
  String get allLevelsFreeBody => 'لا مستويات مقفلة. استمتع!';

  @override
  String get privacyOverviewBody =>
      'نحن نحترم خصوصيتك ونلتزم بحماية معلوماتك الشخصية.';

  @override
  String get privacyDataBody =>
      'يتم تخزين جميع تقدم اللعبة محلياً على جهازك باستخدام التخزين المحلي (Hive). لا نتطلب إنشاء حساب أو تسجيل دخول.';

  @override
  String get privacyStorageBody =>
      'جميع البيانات (التقدم، الإعدادات، الإنجازات) مخزنة محلياً. حذف التطبيق سيزيل جميع البيانات المحلية.';

  @override
  String get privacyChangesBody =>
      'قد نحدث هذه السياسة. الاستمرار في الاستخدام بعد التغييرات يعتبر قبولاً.';

  @override
  String privacyContactBody(String email) {
    return 'للأسئلة، البريد الإلكتروني: $email';
  }

  @override
  String get multiStepLabel => 'متعدد الخطوات';

  @override
  String get stars3 => 'نجوم';

  @override
  String get onboardingHowToPlayBody =>
      '1. انقر على حرف لاختياره\n2. انقر على رقم (0-9) لتخصيصه\n3. كل حرف يجب أن يكون له رقم فريد\n4. اضغط طويلاً على حرف لمسحه';

  @override
  String get onboardingHelpSubtitle => 'التلميحات والتحقق';

  @override
  String get onboardingHelpBody =>
      '• انقر 💡 تلميح للكشف عن حرف\n• انقر ✓ تحقق للفحص\n• الحروف الخاطئة تصبح حمراء والصحيحة خضراء\n• حل بتلميحات أقل لمزيد من ⭐!';

  @override
  String get onboardingDailyBody =>
      '• لغز جديد كل يوم\n• ابنِ سلسلتك 🔥 باللعب يومياً\n• افتح الإنجازات أثناء اللعب\n• 1200 مستوى من سهل إلى خبير — كلها مجانية!';

  @override
  String get onboardingStarExample =>
      '⭐⭐⭐  بدون تلميحات، سريع\n⭐⭐     1-2 تلميحات\n⭐       3+ تلميحات';

  @override
  String usedBy(String letter) {
    return 'مستخدم بواسطة: $letter';
  }

  @override
  String get notUsed => 'غير مستخدم';

  @override
  String get replayConfirmTitle => 'إعادة هذا المستوى؟';

  @override
  String get replayConfirmBody =>
      'لديك بالفعل ⭐⭐⭐ في هذا المستوى. أفضل نتيجة ستبقى.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get newBadge => 'جديد';

  @override
  String get themePicker => 'السمة';

  @override
  String get proThemeHint => 'افتح المزيد من السمات مع Pro';

  @override
  String get shareStats => 'مشاركة الإحصائيات';

  @override
  String get updateAvailable => 'تحديث متاح';

  @override
  String get updateBody => 'إصدار جديد من CryptiQ متاح. حدث الآن لأفضل تجربة!';

  @override
  String get updateNow => 'حدث الآن';

  @override
  String get puzzlesSolved => 'الألغاز المحلولة';

  @override
  String get allDone => 'تم الكل!';

  @override
  String hintCount(int count) {
    return 'تلميح ($count)';
  }

  @override
  String get incorrectTryAgain => 'خطأ — حاول مجدداً!';

  @override
  String playerScored(String player, int score) {
    return '$player حصل على $score نقطة';
  }

  @override
  String hintsCount(int count) {
    return '$count تلميحات';
  }

  @override
  String roundOf(int current, int total) {
    return 'الجولة $current من $total';
  }

  @override
  String get imReady => 'أنا جاهز!';

  @override
  String playerWins(String player) {
    return '$player يفوز!';
  }

  @override
  String playerStatsLine(int solved, int total, String time, int hints) {
    return '$solved/$total محلول • $time • $hints تلميحات';
  }

  @override
  String scorePts(int score) {
    return '$scoreنق';
  }

  @override
  String get playerNameHint => 'اسم اللاعب';

  @override
  String get multiStepNote =>
      'ألغاز متعددة الخطوات للصعب/الخبير فقط. الصعوبة ستُتجاهل.';

  @override
  String percentUnlocked(String percent) {
    return '$percent% مفتوح';
  }

  @override
  String shareDailyText(String time, int streak) {
    return 'حللت تحدي CryptiQ اليومي في $time! 🔥 سلسلة $streak يوم! هل يمكنك التغلب عليه؟\n\n#CryptiQ #التحدي_اليومي';
  }
}
