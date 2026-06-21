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
  String get dailyChallenge => '일일 챌린지';

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
  String get puzzleSolved => '퍼즐 완료!';

  @override
  String get nextLevel => '다음 레벨';

  @override
  String get replay => '다시하기';

  @override
  String get share => '공유';

  @override
  String get time => '시간';

  @override
  String get hints => '힌트';

  @override
  String get allowHints => 'Allow Hints';

  @override
  String get bestTime => '최고 기록';

  @override
  String levelsCompleted(int count, int total) {
    return '$count/$total 완료';
  }

  @override
  String get totalTime => '총 시간';

  @override
  String get averageTime => '평균';

  @override
  String get hintsUsed => '사용한 힌트';

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
  String get storeTitle => 'Store';

  @override
  String get proActiveDesc => 'All premium features unlocked!';

  @override
  String get proDesc => 'Remove all ads forever and support the developer.';

  @override
  String get purchased => 'Purchased';

  @override
  String get restorePurchases => 'Restore Purchases';

  @override
  String get purchasesRestored => 'Purchases restored';

  @override
  String get tryAgain => '다시 시도';

  @override
  String get wrongAnswer => '오답';

  @override
  String get someDigitsWrong => '일부 숫자가 틀렸습니다. 다시 시도해주세요!';

  @override
  String get fillAllLetters => 'Please fill all letters first!';

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
  String get passAndPlay => '패스 앤 플레이';

  @override
  String get decodeTheLogic => '로직을 해독하라';

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
  String get replayTutorial => '튜토리얼 보기';

  @override
  String get version => '버전';

  @override
  String get contactUs => '문의하기';

  @override
  String get resetProgress => '진행 초기화';

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
  String get noHintsUsed => '힌트 없이';

  @override
  String get playAgain => '다시 플레이';

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
  String get noHintsAvailable => '이 퍼즐에 힌트가 없습니다';

  @override
  String get overallProgress => '전체 진행';

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
  String get completeMoreLevels => '다시하려면 더 많은 레벨 완료';

  @override
  String get viewSolution => '풀이 보기';

  @override
  String get attempts => '시도';

  @override
  String get close => '닫기';

  @override
  String get game => '게임';

  @override
  String get soundEffects => '효과음';

  @override
  String get hapticFeedback => '햅틱 피드백';

  @override
  String get dailyReminder => '일일 알림';

  @override
  String get appearance => '외관';

  @override
  String get upgradeToPro => 'Pro로 업그레이드';

  @override
  String get noAds => '광고 없음';

  @override
  String get allThemes => '모든 테마';

  @override
  String get bonusHint => '+1 보너스 힌트';

  @override
  String get goPro => 'Pro 되기';

  @override
  String get proActive => 'CryptiQ Pro ✓';

  @override
  String get byDifficulty => '난이도별';

  @override
  String get totalStars => '총 별';

  @override
  String get avgTime => '평균 시간';

  @override
  String get enjoyingApp => 'CryptiQ가 마음에 드시나요?';

  @override
  String get rateAppBody => '앱이 마음에 드시면 잠시 시간을 내어 평가해 주세요!';

  @override
  String get levelSelectHint =>
      '💡 Tip: Tap to play, long-press a completed level for details.';

  @override
  String get noThanks => '아니요';

  @override
  String get later => '나중에';

  @override
  String get rateNow => '지금 평가 ⭐';

  @override
  String get undo => '실행 취소';

  @override
  String get overview => '개요';

  @override
  String get dataCollection => '데이터 수집';

  @override
  String get thirdPartyServices => '제3자 서비스';

  @override
  String get dataStorage => '데이터 저장';

  @override
  String get childrenPrivacy => '아동 개인정보';

  @override
  String get changes => '변경사항';

  @override
  String get contact => '연락처';

  @override
  String get lastUpdated => '최종 업데이트';

  @override
  String levelsOf(int completed, int total) {
    return '$total레벨 중 $completed완료';
  }

  @override
  String get tutorialWelcomeTitle => 'CryptiQ에 오신 것을 환영합니다!';

  @override
  String get tutorialWelcomeBody =>
      '각 글자는 고유한 숫자(0-9)를 나타냅니다.\n목표: 각 글자가 어떤 숫자를 나타내는지 알아내어\n수식을 올바르게 만드세요.';

  @override
  String get tutorialSelectTitle => '1단계: 글자 선택';

  @override
  String get tutorialSelectBody => '수식의 아무 글자를 탭하세요.\n선택되었음을 보여주며 강조됩니다.';

  @override
  String get tutorialAssignTitle => '2단계: 숫자 할당';

  @override
  String get tutorialAssignBody =>
      '숫자 패드를 사용하여 선택한 글자에\n숫자(0-9)를 할당하세요.\n각 숫자는 한 번만 사용할 수 있습니다!';

  @override
  String get tutorialCheckTitle => '3단계: 답 확인';

  @override
  String get tutorialCheckBody =>
      '모든 글자에 숫자가 있으면 \"확인\"을 탭하세요.\n틀린 글자는 빨간색이 됩니다 — 수정하세요!\n막히면 힌트나 실행 취소를 사용하세요.';

  @override
  String get tutorialGoTitle => '준비 완료!';

  @override
  String get tutorialGoBody => '적은 힌트로 빠르게 풀어 ⭐⭐⭐을 획득하세요!\n행운을 빌며 즐겨주세요! 🧩';

  @override
  String get next => '다음';

  @override
  String get autoFillNext => '다음 글자 자동 선택';

  @override
  String get onboardingWelcomeTitle => 'CryptiQ에 오신 것을 환영합니다!';

  @override
  String get onboardingWelcomeSubtitle => '로직을 해독하라';

  @override
  String get onboardingWelcomeBody =>
      'CryptiQ는 각 글자가 고유한 숫자(0-9)를 나타내는 복면산 퍼즐 게임입니다.\n\n목표: 각 글자에 어떤 숫자가 대응하는지 알아내어 수식을 성립시키세요!';

  @override
  String get onboardingHowToPlay => '플레이 방법';

  @override
  String get onboardingSelectAssign => '선택하고 할당하기';

  @override
  String get onboardingExample => 'S=9, E=5, N=6, D=7일 때\nSEND = 9567';

  @override
  String get onboardingNeedHelp => '도움이 필요한가요?';

  @override
  String get onboardingDailyTitle => '일일 챌린지';

  @override
  String get onboardingDailySubtitle => '매일 돌아오세요!';

  @override
  String get onboardingReady => '준비됐나요? 시작! 🚀';

  @override
  String get skip => '건너뛰기';

  @override
  String get startPlaying => '플레이 시작';

  @override
  String playerName(int number) {
    return '플레이어 $number';
  }

  @override
  String get addPlayer => '플레이어 추가';

  @override
  String roundsLabel(int count) {
    return '라운드: $count';
  }

  @override
  String get addition => '덧셈 (+)';

  @override
  String get subtraction => '뺄셈 (−)';

  @override
  String get multiply => '곱셈 (×)';

  @override
  String get multiStep => '다단계';

  @override
  String get passDevice => '이 플레이어에게 기기를 전달하세요';

  @override
  String get roundDetails => '라운드 상세';

  @override
  String get gaveUp => '포기함';

  @override
  String get beatMyTime => '제 기록을 깰 수 있나요?';

  @override
  String get allLevelsFreeTitle => '1200 레벨 전부 무료';

  @override
  String get allLevelsFreeBody => '잠긴 레벨 없음. 즐기세요!';

  @override
  String get privacyOverviewBody => '우리는 귀하의 개인정보를 존중하며 보호하기 위해 최선을 다합니다.';

  @override
  String get privacyDataBody =>
      '모든 게임 진행은 오프라인 저장소(Hive)를 사용하여 기기에 로컬 저장됩니다. 계정 생성이나 로그인이 필요 없습니다.';

  @override
  String get privacyStorageBody =>
      '모든 데이터(진행, 설정, 업적)는 로컬에 저장됩니다. 앱을 삭제하면 모든 로컬 데이터가 삭제됩니다.';

  @override
  String get privacyChangesBody =>
      '이 정책은 업데이트될 수 있습니다. 변경 후 계속 사용하면 동의로 간주됩니다.';

  @override
  String privacyContactBody(String email) {
    return '문의 이메일: $email';
  }

  @override
  String get multiStepLabel => '다단계';

  @override
  String get stars3 => '별';

  @override
  String get onboardingHowToPlayBody =>
      '1. 글자를 탭하여 선택\n2. 숫자(0-9)를 탭하여 할당\n3. 각 글자는 고유한 숫자여야 합니다\n4. 글자를 길게 눌러 지우기';

  @override
  String get onboardingHelpSubtitle => '힌트와 확인';

  @override
  String get onboardingHelpBody =>
      '• 💡 힌트를 탭하여 글자 공개\n• ✓ 확인을 탭하여 체크\n• 틀린 글자는 빨간색, 맞은 글자는 초록색\n• 힌트를 적게 사용하면 ⭐가 더 많아요!';

  @override
  String get onboardingDailyBody =>
      '• 매일 새로운 퍼즐\n• 매일 플레이하여 연속 기록 🔥 쌓기\n• 플레이하며 업적 달성\n• 쉬움부터 전문가까지 1200레벨 — 전부 무료!';

  @override
  String get onboardingStarExample =>
      '⭐⭐⭐  힌트 없이, 빠르게\n⭐⭐     1-2 힌트\n⭐       3+ 힌트';

  @override
  String usedBy(String letter) {
    return '사용 중: $letter';
  }

  @override
  String get notUsed => '사용 안 함';

  @override
  String get replayConfirmTitle => '이 레벨을 다시하시겠습니까?';

  @override
  String get replayConfirmBody => '이 레벨에 이미 ⭐⭐⭐가 있습니다. 최고 점수는 유지됩니다.';

  @override
  String get cancel => '취소';

  @override
  String get newBadge => 'NEW';

  @override
  String get themePicker => '테마';

  @override
  String get proThemeHint => 'Pro로 더 많은 테마 잠금 해제';

  @override
  String get shareStats => '통계 공유';

  @override
  String get updateAvailable => '업데이트 가능';

  @override
  String get updateBody => '새로운 버전의 CryptiQ가 있습니다. 최고의 경험을 위해 지금 업데이트하세요!';

  @override
  String get updateNow => '지금 업데이트';

  @override
  String get puzzlesSolved => '풀은 퍼즐';

  @override
  String get allDone => '모두 완료!';

  @override
  String hintCount(int count) {
    return '힌트 ($count)';
  }

  @override
  String get incorrectTryAgain => '오답 — 다시 시도!';

  @override
  String playerScored(String player, int score) {
    return '$player이(가) $score점 획득';
  }

  @override
  String hintsCount(int count) {
    return '$count개 힌트';
  }

  @override
  String roundOf(int current, int total) {
    return '라운드 $current/$total';
  }

  @override
  String get imReady => '준비 완료!';

  @override
  String playerWins(String player) {
    return '$player 승리!';
  }

  @override
  String playerStatsLine(int solved, int total, String time, int hints) {
    return '$solved/$total 완료 • $time • $hints개 힌트';
  }

  @override
  String scorePts(int score) {
    return '$score점';
  }

  @override
  String get playerNameHint => '플레이어 이름';

  @override
  String get multiStepNote => '다단계 퍼즐은 어려움/전문가만 가능합니다. 난이도가 무시됩니다.';

  @override
  String percentUnlocked(String percent) {
    return '$percent% 해제됨';
  }

  @override
  String shareDailyText(String time, int streak) {
    return 'CryptiQ 일일 챌린지를 $time에 풀었어요! 🔥 $streak일 연속! 당신도 도전해보세요!\n\n#CryptiQ #일일챌린지';
  }

  @override
  String get achvNoHints10Title => '날카로운 마음';

  @override
  String get achvStreak30Title => '연속 마스터';

  @override
  String get achvStreak14Desc => '14일 일일 연속 도전';

  @override
  String get achvPerfect50Desc => '50레벨에서 별 3개를 획득하세요';

  @override
  String get achvFiveHundredLevelsTitle => '거기 반쯤';

  @override
  String get achvExpertMasterTitle => '전문 암호학자';

  @override
  String get achvLightningDesc => '10초 안에 퍼즐을 풀어보세요';

  @override
  String get achvFirstSolveDesc => '첫 번째 퍼즐을 풀어보세요';

  @override
  String get achvExpertMasterDesc => '모든 전문가 레벨을 완료하세요';

  @override
  String get achvPerfect50Title => '완벽한';

  @override
  String get achvHundredLevelsDesc => '100개의 레벨을 완료하세요';

  @override
  String get achvHundredStarsDesc => '별 100개 획득';

  @override
  String get achvHardMasterDesc => '모든 하드 레벨을 완료하세요';

  @override
  String get achvHundredStarsTitle => '스타헌터';

  @override
  String get achvStreak14Title => '2주 챔피언';

  @override
  String get achvPerfect10Desc => '10개 레벨에서 별 3개를 획득하세요';

  @override
  String get achvHundredLevelsTitle => '백부장';

  @override
  String get achvHardMasterTitle => '강화';

  @override
  String get achvLightningTitle => '번개처럼 빠른';

  @override
  String get achvTenStarsDesc => '별 10개를 획득하세요';

  @override
  String get achvFirstSolveTitle => '첫 번째 단계';

  @override
  String get achvStreak7Desc => '7일 일일 연속 도전';

  @override
  String get achvPerfect10Title => '완벽주의자';

  @override
  String get achvMediumMasterDesc => '모든 중간 레벨을 완료하세요';

  @override
  String get achvSpeedDemonDesc => '15초 안에 퍼즐을 풀어보세요';

  @override
  String get achvTenStarsTitle => '스타 콜렉터';

  @override
  String get achvFiftyLevelsDesc => '50개의 레벨을 완료하세요';

  @override
  String get achvStreak7Title => '주간 전사';

  @override
  String get achvNoHints50Desc => '힌트 없이 퍼즐 50개를 풀어보세요';

  @override
  String get achvMediumMasterTitle => '미디엄 레어';

  @override
  String get achvSpeedDemonTitle => '속도의 악마';

  @override
  String get achvThousandLevelsDesc => '1000개의 레벨을 완료하세요';

  @override
  String get achvFiftyLevelsTitle => '퍼즐 매니아';

  @override
  String get achvNoHints50Title => '순수한 천재';

  @override
  String get achvThousandStarsDesc => '별 1000개 획득';

  @override
  String get achvThousandLevelsTitle => '그랜드 마스터';

  @override
  String get achvStreak3Desc => '3일 연속 일일 도전';

  @override
  String get achvEasyMasterDesc => '모든 쉬운 레벨을 완료하세요';

  @override
  String get achvNoHints10Desc => '힌트 없이 퍼즐 10개를 풀어보세요';

  @override
  String get achvStreak100Title => '멈출 수 없는';

  @override
  String get achvStreak3Title => '롤에';

  @override
  String get achvThousandStarsTitle => '별자리';

  @override
  String get achvTenLevelsTitle => '워밍업하기';

  @override
  String get achvEasyMasterTitle => '쉬운 Peasy';

  @override
  String get achvTenLevelsDesc => '10개의 레벨을 완료하세요';

  @override
  String get achvStreak30Desc => '30일 연속 일일 도전';

  @override
  String get achvFiveHundredLevelsDesc => '500개의 레벨을 완료하세요';

  @override
  String get achvStreak100Desc => '100일 연속 일일 도전';

  @override
  String get achvMultiStepFirstTitle => '연쇄반응';

  @override
  String get achvMultiStepFirstDesc => '첫 번째 다단계 퍼즐을 풀어보세요';

  @override
  String get achvMultiStepAllDesc => '200개의 다단계 퍼즐을 모두 완료하세요';

  @override
  String get achvMultiStepAllTitle => '캐스케이드 킹';
}
