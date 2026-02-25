import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for ko (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([super.locale = 'ko']);

  @override
  String get appTitle => 'CryptiQ';

  @override
  String get play => '플레이';

  @override
  String get dailyChallenge => '일일 도전';

  @override
  String get statistics => '통계';

  @override
  String get settings => '설정';

  @override
  String level(int number) {
    return '레벨 {number}';
  }

  @override
  String get easy => '쉬움';

  @override
  String get medium => '보통';

  @override
  String get hard => '어려움';

  @override
  String get expert => '전문가';

  @override
  String get hint => '힌트';

  @override
  String get check => '확인';

  @override
  String get clear => '지우기';

  @override
  String get clearAll => '모두 지우기';

  @override
  String get congratulations => '축하합니다!';

  @override
  String get puzzleSolved => '퍼즐 완성!';

  @override
  String get nextLevel => '다음 레벨';

  @override
  String get replay => '다시 하기';

  @override
  String get share => '공유';

  @override
  String get time => '시간';

  @override
  String get hints => '힌트';

  @override
  String get bestTime => '최고 기록';

  @override
  String get levelsCompleted => '완료한 레벨';

  @override
  String get totalTime => '총 시간';

  @override
  String get averageTime => '평균 시간';

  @override
  String get hintsUsed => '힌트 사용';

  @override
  String get currentStreak => '현재 연속';

  @override
  String get bestStreak => '최고 연속';

  @override
  String get sound => '소리';

  @override
  String get haptics => '진동';

  @override
  String get language => '언어';

  @override
  String get about => '정보';

  @override
  String get privacyPolicy => '개인정보 처리방침';

  @override
  String get rateApp => '앱 평가';

  @override
  String get removeAds => '광고 제거';

  @override
  String get restorePurchase => '구매 복원';

  @override
  String get tryAgain => '다시 시도';

  @override
  String get wrongAnswer => '오답';

  @override
  String get someDigitsWrong => '일부 숫자가 틀렸습니다. 다시 시도하세요!';

  @override
  String get allLevelsFree => '모든 레벨 무료!';

  @override
  String get noLockedLevels => '잠긴 레벨 없음.';

  @override
  String get home => '홈';

  @override
  String get back => '뒤로';

  @override
  String get resume => '이어하기';

  @override
  String stars(int count) {
    return '{count} 별';
  }

}
