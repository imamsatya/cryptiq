// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'CryptiQ';

  @override
  String get play => 'プレイ';

  @override
  String get dailyChallenge => 'デイリーチャレンジ';

  @override
  String get statistics => '統計';

  @override
  String get settings => '設定';

  @override
  String level(int number) {
    return 'レベル $number';
  }

  @override
  String get easy => '簡単';

  @override
  String get medium => '普通';

  @override
  String get hard => '難しい';

  @override
  String get expert => 'エキスパート';

  @override
  String get hint => 'ヒント';

  @override
  String get check => '確認';

  @override
  String get clear => 'クリア';

  @override
  String get clearAll => '全てクリア';

  @override
  String get congratulations => 'おめでとう！';

  @override
  String get puzzleSolved => 'パズル完成！';

  @override
  String get nextLevel => '次のレベル';

  @override
  String get replay => 'リプレイ';

  @override
  String get share => 'シェア';

  @override
  String get time => '時間';

  @override
  String get hints => 'ヒント';

  @override
  String get bestTime => '最速タイム';

  @override
  String levelsCompleted(int count, int total) {
    return 'クリア数';
  }

  @override
  String get totalTime => '合計時間';

  @override
  String get averageTime => '平均時間';

  @override
  String get hintsUsed => 'ヒント使用';

  @override
  String get currentStreak => '現在の連続';

  @override
  String get bestStreak => '最高連続';

  @override
  String get sound => 'サウンド';

  @override
  String get haptics => '振動';

  @override
  String get language => '言語';

  @override
  String get about => '情報';

  @override
  String get privacyPolicy => 'プライバシー';

  @override
  String get rateApp => 'アプリを評価';

  @override
  String get removeAds => '広告を削除';

  @override
  String get restorePurchase => '購入を復元';

  @override
  String get tryAgain => 'もう一度';

  @override
  String get wrongAnswer => '不正解';

  @override
  String get someDigitsWrong => 'いくつかの数字が間違っています。もう一度！';

  @override
  String get allLevelsFree => '全レベル無料！';

  @override
  String get noLockedLevels => 'ロックされたレベルはありません。';

  @override
  String get home => 'ホーム';

  @override
  String get back => '戻る';

  @override
  String get resume => '続ける';

  @override
  String stars(int count) {
    return '$count スター';
  }

  @override
  String get selectLevel => 'レベル選択';

  @override
  String get badges => 'バッジ';

  @override
  String get passAndPlay => 'パス＆プレイ (2-4)';

  @override
  String get decodeTheLogic => 'ロジックを解読';

  @override
  String continueLevel(int number) {
    return '続ける (レベル $number)';
  }

  @override
  String get selectDifficulty => '難易度選択';

  @override
  String get all => '全て';

  @override
  String get completed => '完了';

  @override
  String get locked => 'ロック中';

  @override
  String get unlocked => '解除済み';

  @override
  String get theme => 'テーマ';

  @override
  String get replayTutorial => 'チュートリアル';

  @override
  String get version => 'バージョン';

  @override
  String get contactUs => 'お問い合わせ';

  @override
  String get resetProgress => 'リセット';

  @override
  String get correct => '正解！';

  @override
  String get incorrect => '不正解';

  @override
  String get round => 'ラウンド';

  @override
  String get player => 'プレイヤー';

  @override
  String get score => 'スコア';

  @override
  String get winner => '勝者';

  @override
  String get draw => '引き分け';

  @override
  String get players => 'プレイヤー';

  @override
  String get rounds => 'ラウンド';

  @override
  String get difficulty => '難易度';

  @override
  String get operation => '演算';

  @override
  String get mixed => 'ミックス';

  @override
  String get startGame => '開始';

  @override
  String get achievements => '実績';

  @override
  String get streak => '連続記録';

  @override
  String get solvedIn => '解答時間';

  @override
  String get seconds => '秒';

  @override
  String get noHintsUsed => 'ヒントなし';

  @override
  String get playAgain => 'もう一度';

  @override
  String get results => '結果';

  @override
  String get dailyStreak => '連続チャレンジ';

  @override
  String get giveUp => 'ギブアップ';

  @override
  String get rematch => '再戦';

  @override
  String get achievementUnlocked => '実績解除！';

  @override
  String get noHintsAvailable => 'ヒントがありません';

  @override
  String get overallProgress => '全体の進捗';

  @override
  String roundNumber(int number) {
    return 'ラウンド $number';
  }

  @override
  String dayStreak(int count) {
    return '$count日連続！';
  }

  @override
  String get shareResult => '結果をシェア';

  @override
  String get dailyComplete => 'デイリーチャレンジ完了！';

  @override
  String get completeMoreLevels => 'リプレイするにはもっとレベルをクリアしてください';

  @override
  String get viewSolution => '解答を見る';

  @override
  String get attempts => '試行回数';

  @override
  String get close => '閉じる';

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

  @override
  String get onboardingHowToPlayBody =>
      '1. Tap a letter tile to select it\n2. Tap a number (0-9) to assign it\n3. Each letter must have a unique digit\n4. Long-press a letter to clear it';

  @override
  String get onboardingHelpSubtitle => 'Hints & Checking';

  @override
  String get onboardingHelpBody =>
      '• Tap 💡 Hint to reveal one correct letter\n• Tap ✓ Check to verify your solution\n• Wrong letters glow red, correct ones glow green\n• Try to solve with fewer hints for more ⭐ stars!';

  @override
  String get onboardingDailyBody =>
      '• A new puzzle appears every day\n• Build your streak 🔥 by playing daily\n• Unlock achievements as you play\n• 1200 levels from Easy to Expert — all FREE!';

  @override
  String get onboardingStarExample =>
      '⭐⭐⭐  No hints, fast solve\n⭐⭐     1-2 hints\n⭐       3+ hints';

  @override
  String usedBy(String letter) {
    return 'Used by: $letter';
  }

  @override
  String get notUsed => 'Not used';

  @override
  String get replayConfirmTitle => 'Replay this level?';

  @override
  String get replayConfirmBody =>
      'You already have ⭐⭐⭐ on this level. Your best score will be kept.';

  @override
  String get cancel => 'Cancel';

  @override
  String get newBadge => 'NEW';

  @override
  String get themePicker => 'Theme';

  @override
  String get proThemeHint => 'Unlock more themes with Pro';

  @override
  String get shareStats => 'Share Stats';

  @override
  String get updateAvailable => 'Update Available';

  @override
  String get updateBody =>
      'A new version of CryptiQ is available. Update now for the best experience!';

  @override
  String get updateNow => 'Update Now';

  @override
  String get puzzlesSolved => 'Puzzles Solved';
}
