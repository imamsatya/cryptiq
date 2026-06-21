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
  String get clear => '消去';

  @override
  String get clearAll => '全消去';

  @override
  String get congratulations => 'おめでとう！';

  @override
  String get puzzleSolved => 'パズルクリア！';

  @override
  String get nextLevel => '次のレベル';

  @override
  String get replay => 'リプレイ';

  @override
  String get share => '共有';

  @override
  String get time => '時間';

  @override
  String get hints => 'ヒント';

  @override
  String get allowHints => 'Allow Hints';

  @override
  String get bestTime => 'ベストタイム';

  @override
  String levelsCompleted(int count, int total) {
    return '$count/$total クリア';
  }

  @override
  String get totalTime => '合計時間';

  @override
  String get averageTime => '平均';

  @override
  String get hintsUsed => '使用ヒント';

  @override
  String get currentStreak => '現在の連続記録';

  @override
  String get bestStreak => '最高連続記録';

  @override
  String get sound => 'サウンド';

  @override
  String get haptics => '触覚';

  @override
  String get language => '言語';

  @override
  String get about => 'このアプリについて';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get rateApp => 'アプリを評価';

  @override
  String get removeAds => '広告を削除';

  @override
  String get restorePurchase => '購入を復元';

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
  String get tryAgain => 'もう一度';

  @override
  String get wrongAnswer => '不正解';

  @override
  String get someDigitsWrong => '一部の数字が間違っています。もう一度お試しください！';

  @override
  String get fillAllLetters => 'Please fill all letters first!';

  @override
  String get allLevelsFree => '全レベル無料！';

  @override
  String get noLockedLevels => 'ロックされたレベルはありません。';

  @override
  String get home => 'ホーム';

  @override
  String get back => '戻る';

  @override
  String get resume => '再開';

  @override
  String stars(int count) {
    return '$count スター';
  }

  @override
  String get selectLevel => 'レベル選択';

  @override
  String get badges => 'バッジ';

  @override
  String get passAndPlay => 'パス＆プレイ';

  @override
  String get decodeTheLogic => 'ロジックを解読せよ';

  @override
  String continueLevel(int number) {
    return '続ける (レベル $number)';
  }

  @override
  String get selectDifficulty => '難易度選択';

  @override
  String get all => 'すべて';

  @override
  String get completed => 'クリア済';

  @override
  String get locked => 'ロック';

  @override
  String get unlocked => '解放済';

  @override
  String get theme => 'テーマ';

  @override
  String get replayTutorial => 'チュートリアルを見る';

  @override
  String get version => 'バージョン';

  @override
  String get contactUs => 'お問い合わせ';

  @override
  String get resetProgress => '進捗リセット';

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
  String get solvedIn => 'クリアタイム';

  @override
  String get seconds => '秒';

  @override
  String get noHintsUsed => 'ヒントなし';

  @override
  String get playAgain => 'もう一度プレイ';

  @override
  String get results => '結果';

  @override
  String get dailyStreak => 'デイリー連続記録';

  @override
  String get giveUp => 'ギブアップ';

  @override
  String get rematch => '再戦';

  @override
  String get achievementUnlocked => '実績解除！';

  @override
  String get noHintsAvailable => 'このパズルにヒントはありません';

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
  String get shareResult => '結果を共有';

  @override
  String get dailyComplete => 'デイリーチャレンジ完了！';

  @override
  String get completeMoreLevels => 'リプレイするにはもっとレベルをクリア';

  @override
  String get viewSolution => '解答を見る';

  @override
  String get attempts => '試行回数';

  @override
  String get close => '閉じる';

  @override
  String get game => 'ゲーム';

  @override
  String get soundEffects => '効果音';

  @override
  String get hapticFeedback => '触覚フィードバック';

  @override
  String get dailyReminder => 'デイリーリマインダー';

  @override
  String get appearance => '外観';

  @override
  String get upgradeToPro => 'Proにアップグレード';

  @override
  String get noAds => '広告なし';

  @override
  String get allThemes => '全テーマ';

  @override
  String get bonusHint => '+1 ボーナスヒント';

  @override
  String get goPro => 'Proになる';

  @override
  String get proActive => 'CryptiQ Pro ✓';

  @override
  String get byDifficulty => '難易度別';

  @override
  String get totalStars => '合計スター';

  @override
  String get avgTime => '平均時間';

  @override
  String get enjoyingApp => 'CryptiQを楽しんでいますか？';

  @override
  String get rateAppBody => 'アプリが気に入ったら、ぜひ評価してください！';

  @override
  String get levelSelectHint =>
      '💡 Tip: Tap to play, long-press a completed level for details.';

  @override
  String get noThanks => 'いいえ';

  @override
  String get later => '後で';

  @override
  String get rateNow => '今すぐ評価 ⭐';

  @override
  String get undo => '元に戻す';

  @override
  String get overview => '概要';

  @override
  String get dataCollection => 'データ収集';

  @override
  String get thirdPartyServices => 'サードパーティサービス';

  @override
  String get dataStorage => 'データ保存';

  @override
  String get childrenPrivacy => '子供のプライバシー';

  @override
  String get changes => '変更';

  @override
  String get contact => '連絡先';

  @override
  String get lastUpdated => '最終更新';

  @override
  String levelsOf(int completed, int total) {
    return '$totalレベル中$completedクリア';
  }

  @override
  String get tutorialWelcomeTitle => 'CryptiQへようこそ！';

  @override
  String get tutorialWelcomeBody =>
      '各文字は一意の数字(0-9)を表します。\n目標：各文字がどの数字を表すかを解き明かし、\n式を正しくしましょう。';

  @override
  String get tutorialSelectTitle => 'ステップ1：文字を選択';

  @override
  String get tutorialSelectBody => '式の中の任意の文字をタップします。\n選択中であることが強調表示されます。';

  @override
  String get tutorialAssignTitle => 'ステップ2：数字を割り当て';

  @override
  String get tutorialAssignBody =>
      'テンキーを使って選択した文字に\n数字(0-9)を割り当てます。\n各数字は一度しか使えません！';

  @override
  String get tutorialCheckTitle => 'ステップ3：答えを確認';

  @override
  String get tutorialCheckBody =>
      '全文字に数字を入れたら「確認」をタップ。\n間違った文字は赤くなります — 修正しましょう！\n困ったらヒントや元に戻すを使いましょう。';

  @override
  String get tutorialGoTitle => '準備完了！';

  @override
  String get tutorialGoBody => '少ないヒントで素早く解いて⭐⭐⭐を獲得！\n頑張って楽しんでください！🧩';

  @override
  String get next => '次へ';

  @override
  String get autoFillNext => '次の文字を自動選択';

  @override
  String get onboardingWelcomeTitle => 'CryptiQへようこそ！';

  @override
  String get onboardingWelcomeSubtitle => 'ロジックを解読せよ';

  @override
  String get onboardingWelcomeBody =>
      'CryptiQは各文字が一意の数字(0-9)を表す覆面算パズルゲームです。\n\n目標：各文字にどの数字が対応するかを解き明かし、式を成立させましょう！';

  @override
  String get onboardingHowToPlay => '遊び方';

  @override
  String get onboardingSelectAssign => '選択して割り当て';

  @override
  String get onboardingExample => 'S=9, E=5, N=6, D=7 の場合\nSEND = 9567';

  @override
  String get onboardingNeedHelp => 'ヘルプが必要？';

  @override
  String get onboardingDailyTitle => 'デイリーチャレンジ';

  @override
  String get onboardingDailySubtitle => '毎日戻ってきてね！';

  @override
  String get onboardingReady => '準備はいい？行こう！🚀';

  @override
  String get skip => 'スキップ';

  @override
  String get startPlaying => 'プレイ開始';

  @override
  String playerName(int number) {
    return 'プレイヤー $number';
  }

  @override
  String get addPlayer => 'プレイヤー追加';

  @override
  String roundsLabel(int count) {
    return 'ラウンド: $count';
  }

  @override
  String get addition => '足し算 (+)';

  @override
  String get subtraction => '引き算 (−)';

  @override
  String get multiply => '掛け算 (×)';

  @override
  String get multiStep => '多段階';

  @override
  String get passDevice => 'このプレイヤーにデバイスを渡してください';

  @override
  String get roundDetails => 'ラウンド詳細';

  @override
  String get gaveUp => 'ギブアップ';

  @override
  String get beatMyTime => '私のタイムを超えられる？';

  @override
  String get allLevelsFreeTitle => '全1200レベル無料';

  @override
  String get allLevelsFreeBody => 'ロックされたレベルはありません。お楽しみください！';

  @override
  String get privacyOverviewBody => '私たちはあなたのプライバシーを尊重し、個人情報の保護に努めています。';

  @override
  String get privacyDataBody =>
      'すべてのゲーム進捗はオフラインストレージ(Hive)を使用してデバイスにローカル保存されます。アカウント作成やログインは不要です。';

  @override
  String get privacyStorageBody =>
      'すべてのデータ（進捗、設定、実績）はローカルに保存されます。アプリをアンインストールするとすべてのローカルデータが削除されます。';

  @override
  String get privacyChangesBody => 'このポリシーは更新される場合があります。変更後の継続使用は同意とみなされます。';

  @override
  String privacyContactBody(String email) {
    return 'ご質問はメールで: $email';
  }

  @override
  String get multiStepLabel => '多段階';

  @override
  String get stars3 => 'スター';

  @override
  String get onboardingHowToPlayBody =>
      '1. 文字をタップして選択\n2. 数字(0-9)をタップして割り当て\n3. 各文字には一意の数字が必要\n4. 文字を長押しでクリア';

  @override
  String get onboardingHelpSubtitle => 'ヒントと確認';

  @override
  String get onboardingHelpBody =>
      '• 💡ヒントをタップで文字を表示\n• ✓確認をタップでチェック\n• 間違った文字は赤、正しい文字は緑\n• ヒントを少なく解くほど⭐が多い！';

  @override
  String get onboardingDailyBody =>
      '• 毎日新しいパズル\n• 毎日プレイして連続記録🔥を作ろう\n• プレイしながら実績を解除\n• 簡単からエキスパートまで1200レベル — 全て無料！';

  @override
  String get onboardingStarExample =>
      '⭐⭐⭐  ヒントなし、速い\n⭐⭐     1-2ヒント\n⭐       3+ヒント';

  @override
  String usedBy(String letter) {
    return '使用中: $letter';
  }

  @override
  String get notUsed => '未使用';

  @override
  String get replayConfirmTitle => 'このレベルをリプレイしますか？';

  @override
  String get replayConfirmBody => 'このレベルはすでに⭐⭐⭐です。ベストスコアは保持されます。';

  @override
  String get cancel => 'キャンセル';

  @override
  String get newBadge => 'NEW';

  @override
  String get themePicker => 'テーマ';

  @override
  String get proThemeHint => 'Proでもっとテーマを解放';

  @override
  String get shareStats => '統計を共有';

  @override
  String get updateAvailable => 'アップデート利用可能';

  @override
  String get updateBody => 'CryptiQの新バージョンが利用可能です。最高の体験のために今すぐアップデート！';

  @override
  String get updateNow => '今すぐアップデート';

  @override
  String get puzzlesSolved => '解いたパズル';

  @override
  String get allDone => '全部完了！';

  @override
  String hintCount(int count) {
    return 'ヒント ($count)';
  }

  @override
  String get incorrectTryAgain => '不正解 — もう一度！';

  @override
  String playerScored(String player, int score) {
    return '$playerが$scoreポイント獲得';
  }

  @override
  String hintsCount(int count) {
    return '$countヒント';
  }

  @override
  String roundOf(int current, int total) {
    return 'ラウンド $current/$total';
  }

  @override
  String get imReady => '準備OK！';

  @override
  String playerWins(String player) {
    return '$playerの勝ち！';
  }

  @override
  String playerStatsLine(int solved, int total, String time, int hints) {
    return '$solved/$totalクリア • $time • $hintsヒント';
  }

  @override
  String scorePts(int score) {
    return '${score}pt';
  }

  @override
  String get playerNameHint => 'プレイヤー名';

  @override
  String get multiStepNote => '多段階パズルは難しい/エキスパートのみです。難易度は無視されます。';

  @override
  String percentUnlocked(String percent) {
    return '$percent% 解放済';
  }

  @override
  String shareDailyText(String time, int streak) {
    return 'CryptiQのデイリーチャレンジを$timeでクリア！🔥 $streak日連続！あなたも挑戦してみて？\n\n#CryptiQ #デイリーチャレンジ';
  }

  @override
  String get achvNoHints10Title => 'シャープな心';

  @override
  String get achvStreak30Title => 'ストリークマスター';

  @override
  String get achvStreak14Desc => '14 日間の毎日のチャレンジ連続記録';

  @override
  String get achvPerfect50Desc => '50 レベルで 3 つ星を獲得';

  @override
  String get achvFiveHundredLevelsTitle => '半分そこまで';

  @override
  String get achvExpertMasterTitle => '暗号専門家';

  @override
  String get achvLightningDesc => '10秒以内にパズルを解く';

  @override
  String get achvFirstSolveDesc => '最初のパズルを解く';

  @override
  String get achvExpertMasterDesc => 'すべてのエキスパートレベルをクリアする';

  @override
  String get achvPerfect50Title => '完璧';

  @override
  String get achvHundredLevelsDesc => '100レベルをクリアする';

  @override
  String get achvHundredStarsDesc => '100 スターを獲得する';

  @override
  String get achvHardMasterDesc => 'すべてのハードレベルをクリアする';

  @override
  String get achvHundredStarsTitle => 'スターハンター';

  @override
  String get achvStreak14Title => '2週間チャンピオン';

  @override
  String get achvPerfect10Desc => '10 レベルで 3 つ星を獲得する';

  @override
  String get achvHundredLevelsTitle => 'センチュリオン';

  @override
  String get achvHardMasterTitle => '硬化した';

  @override
  String get achvLightningTitle => '電光石火の速さ';

  @override
  String get achvTenStarsDesc => '10 つ星を獲得する';

  @override
  String get achvFirstSolveTitle => '最初のステップ';

  @override
  String get achvStreak7Desc => '7日間のデイリーチャレンジ連続達成';

  @override
  String get achvPerfect10Title => '完璧主義者';

  @override
  String get achvMediumMasterDesc => '中レベルをすべてクリアする';

  @override
  String get achvSpeedDemonDesc => '15 秒以内にパズルを解く';

  @override
  String get achvTenStarsTitle => 'スターコレクター';

  @override
  String get achvFiftyLevelsDesc => '50 レベルを完了する';

  @override
  String get achvStreak7Title => '週の戦士';

  @override
  String get achvNoHints50Desc => 'ヒントなしで 50 個のパズルを解く';

  @override
  String get achvMediumMasterTitle => 'ミディアムレア';

  @override
  String get achvSpeedDemonTitle => 'スピードデーモン';

  @override
  String get achvThousandLevelsDesc => '1000 レベルをクリアする';

  @override
  String get achvFiftyLevelsTitle => 'パズル愛好家';

  @override
  String get achvNoHints50Title => '純粋な天才';

  @override
  String get achvThousandStarsDesc => '1000 スターを獲得する';

  @override
  String get achvThousandLevelsTitle => 'グランドマスター';

  @override
  String get achvStreak3Desc => '3 日間のデイリーチャレンジ連続達成';

  @override
  String get achvEasyMasterDesc => 'Easy レベルをすべてクリアする';

  @override
  String get achvNoHints10Desc => 'ヒントなしで 10 個のパズルを解く';

  @override
  String get achvStreak100Title => '止められない';

  @override
  String get achvStreak3Title => 'オン・ア・ロール';

  @override
  String get achvThousandStarsTitle => '星座';

  @override
  String get achvTenLevelsTitle => 'ウォーミングアップ';

  @override
  String get achvEasyMasterTitle => 'イージーピージー';

  @override
  String get achvTenLevelsDesc => '10 レベルを完了する';

  @override
  String get achvStreak30Desc => '毎日 30 日間連続チャレンジ';

  @override
  String get achvFiveHundredLevelsDesc => '500 レベルをクリアする';

  @override
  String get achvStreak100Desc => '毎日100日連続チャレンジ達成';

  @override
  String get achvMultiStepFirstTitle => '連鎖反応';

  @override
  String get achvMultiStepFirstDesc => '初めての複数ステップのパズルを解く';

  @override
  String get achvMultiStepAllDesc => '200 のマルチステップ パズルをすべて完了する';

  @override
  String get achvMultiStepAllTitle => 'カスケードキング';
}
