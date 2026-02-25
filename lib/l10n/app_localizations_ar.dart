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
    return 'المستوى {number}';
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
  String get totalTime => 'الوقت الكلي';

  @override
  String get averageTime => 'متوسط الوقت';

  @override
  String get hintsUsed => 'تلميحات مستخدمة';

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
  String get resume => 'استئناف';

  @override
  String stars(int count) {
    return '{count} نجوم';
  }

}
