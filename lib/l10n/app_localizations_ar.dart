import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for ar (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([super.locale = 'ar']);

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
    return 'المستوى \${number}';
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
  String get levelsCompleted => 'المستويات المكتملة';

  @override
  String get totalTime => 'الوقت الإجمالي';

  @override
  String get averageTime => 'متوسط الوقت';

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
  String get privacyPolicy => 'الخصوصية';

  @override
  String get rateApp => 'تقييم التطبيق';

  @override
  String get removeAds => 'إزالة الإعلانات';

  @override
  String get restorePurchase => 'استعادة الشراء';

  @override
  String get tryAgain => 'حاول مرة أخرى';

  @override
  String get wrongAnswer => 'إجابة خاطئة';

  @override
  String get someDigitsWrong => 'بعض الأرقام غير صحيحة. حاول مرة أخرى!';

  @override
  String get allLevelsFree => 'جميع المستويات مجانية!';

  @override
  String get noLockedLevels => 'لا مستويات مقفلة، أبداً.';

  @override
  String get home => 'الرئيسية';

  @override
  String get back => 'رجوع';

  @override
  String get resume => 'متابعة';

  @override
  String stars(int count) {
    return '\${count} نجوم';
  }

  @override
  String get selectLevel => 'اختر المستوى';

  @override
  String get badges => 'الشارات';

  @override
  String get passAndPlay => 'تمرير ولعب (2-4)';

  @override
  String get decodeTheLogic => 'فك شيفرة المنطق';

  @override
  String continueLevel(int number) {
    return 'متابعة (المستوى \${number})';
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
  String get resetProgress => 'إعادة التعيين';

  @override
  String get correct => 'صحيح!';

  @override
  String get incorrect => 'خطأ';

  @override
  String get round => 'جولة';

  @override
  String get player => 'لاعب';

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
  String get solvedIn => 'حُل في';

  @override
  String get seconds => 'ثانية';

  @override
  String get noHintsUsed => 'بدون تلميحات';

  @override
  String get playAgain => 'العب مجدداً';

  @override
  String get results => 'النتائج';

  @override
  String get dailyStreak => 'سلسلة يومية';

  @override
  String get giveUp => 'استسلم';

  @override
  String get rematch => 'إعادة المباراة';

  @override
  String get achievementUnlocked => 'إنجاز مفتوح!';

  @override
  String get noHintsAvailable => 'لا تلميحات متبقية';

  @override
  String get overallProgress => 'التقدم العام';

  @override
  String roundNumber(int number) {
    return 'جولة \${number}';
  }

  @override
  String dayStreak(int count) {
    return '\${count} يوم متتالي!';
  }

  @override
  String get shareResult => 'مشاركة النتيجة';

  @override
  String get dailyComplete => 'التحدي اليومي مكتمل!';

  @override
  String get completeMoreLevels => 'أكمل المزيد من المستويات لإعادة اللعب';

  @override
  String get viewSolution => 'عرض الحل';

}
