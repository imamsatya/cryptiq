// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

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
    return '레벨 $number';
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
  String get privacyPolicy => '개인정보';

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
  String get resume => '계속하기';

  @override
  String stars(int count) {
    return '$count 별';
  }

  @override
  String get selectLevel => '레벨 선택';

  @override
  String get badges => '배지';

  @override
  String get passAndPlay => '패스 앤 플레이 (2-4)';

  @override
  String get decodeTheLogic => '논리를 해독하세요';

  @override
  String continueLevel(int number) {
    return '계속하기 (레벨 $number)';
  }

  @override
  String get selectDifficulty => '난이도 선택';

  @override
  String get all => '전체';

  @override
  String get completed => '완료';

  @override
  String get locked => '잠김';

  @override
  String get unlocked => '해제됨';

  @override
  String get theme => '테마';

  @override
  String get replayTutorial => '튜토리얼';

  @override
  String get version => '버전';

  @override
  String get contactUs => '문의';

  @override
  String get resetProgress => '초기화';

  @override
  String get correct => '정답!';

  @override
  String get incorrect => '오답';

  @override
  String get round => '라운드';

  @override
  String get player => '플레이어';

  @override
  String get score => '점수';

  @override
  String get winner => '승자';

  @override
  String get draw => '무승부';

  @override
  String get players => '플레이어';

  @override
  String get rounds => '라운드';

  @override
  String get difficulty => '난이도';

  @override
  String get operation => '연산';

  @override
  String get mixed => '혼합';

  @override
  String get startGame => '시작';

  @override
  String get achievements => '업적';

  @override
  String get streak => '연속';

  @override
  String get solvedIn => '풀이 시간';

  @override
  String get seconds => '초';

  @override
  String get noHintsUsed => '힌트 미사용';

  @override
  String get playAgain => '다시 하기';

  @override
  String get results => '결과';

  @override
  String get dailyStreak => '일일 연속';

  @override
  String get giveUp => '포기';

  @override
  String get rematch => '재대결';

  @override
  String get achievementUnlocked => '업적 달성!';

  @override
  String get noHintsAvailable => '이 퍼즐에 힌트 없음';

  @override
  String get overallProgress => '전체 진행률';

  @override
  String roundNumber(int number) {
    return '라운드 $number';
  }

  @override
  String dayStreak(int count) {
    return '$count일 연속!';
  }

  @override
  String get shareResult => '결과 공유';

  @override
  String get dailyComplete => '일일 챌린지 완료!';

  @override
  String get completeMoreLevels => '리플레이하려면 더 많은 레벨을 완료하세요';

  @override
  String get viewSolution => '풀이 보기';

  @override
  String get attempts => '시도';

  @override
  String get close => '닫기';

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

  @override
  String get onboardingWelcomeTitle => 'Welcome to CryptiQ!';

  @override
  String get onboardingWelcomeSubtitle => 'Decode the Logic';

  @override
  String get onboardingWelcomeBody =>
      'CryptiQ is a cryptarithm puzzle game where each letter represents a unique digit (0-9).\n\nYour goal: figure out which digit goes with which letter to make the equation true!';

  @override
  String get onboardingHowToPlay => 'How to Play';

  @override
  String get onboardingSelectAssign => 'Select & Assign';

  @override
  String get onboardingExample => 'If S=9, E=5, N=6, D=7\nthen SEND = 9567';

  @override
  String get onboardingNeedHelp => 'Need Help?';

  @override
  String get onboardingDailyTitle => 'Daily Challenge';

  @override
  String get onboardingDailySubtitle => 'Come Back Every Day!';

  @override
  String get onboardingReady => 'Ready? Let\'s go! 🚀';

  @override
  String get skip => 'Skip';

  @override
  String get startPlaying => 'Start Playing';

  @override
  String playerName(int number) {
    return 'Player $number';
  }

  @override
  String get addPlayer => 'Add Player';

  @override
  String roundsLabel(int count) {
    return 'Rounds: $count';
  }

  @override
  String get addition => 'Addition (+)';

  @override
  String get subtraction => 'Subtraction (−)';

  @override
  String get multiply => 'Multiply (×)';

  @override
  String get multiStep => 'Multi-step';

  @override
  String get passDevice => 'Pass the device to this player';

  @override
  String get roundDetails => 'Round Details';

  @override
  String get gaveUp => 'Gave up';

  @override
  String get beatMyTime => 'Can you beat my time?';

  @override
  String get allLevelsFreeTitle => 'All 1200 Levels FREE';

  @override
  String get allLevelsFreeBody => 'No locked levels, no paywall. Enjoy!';

  @override
  String get privacyOverviewBody =>
      'We respect your privacy and are committed to protecting your personal information.';

  @override
  String get privacyDataBody =>
      'All game progress is stored locally on your device using offline storage (Hive). We do not require account creation or login.';

  @override
  String get privacyStorageBody =>
      'All data (game progress, settings, achievements) is stored locally on your device. Uninstalling the app will remove all local data.';

  @override
  String get privacyChangesBody =>
      'We may update this policy. Continued use of the app after changes constitutes acceptance.';

  @override
  String privacyContactBody(String email) {
    return 'For questions, email: $email';
  }

  @override
  String get multiStepLabel => 'Multi-step';

  @override
  String get stars3 => 'Stars';
}
