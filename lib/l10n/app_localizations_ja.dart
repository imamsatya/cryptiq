import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for ja (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([super.locale = 'ja']);

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
    return 'レベル {number}';
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
  String get bestTime => '最高タイム';

  @override
  String get levelsCompleted => 'クリア数';

  @override
  String get totalTime => '合計時間';

  @override
  String get averageTime => '平均時間';

  @override
  String get hintsUsed => 'ヒント使用数';

  @override
  String get currentStreak => '連続記録';

  @override
  String get bestStreak => '最高連続記録';

  @override
  String get sound => 'サウンド';

  @override
  String get haptics => '振動';

  @override
  String get language => '言語';

  @override
  String get about => 'アプリについて';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

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
  String get resume => '再開';

  @override
  String stars(int count) {
    return '{count} スター';
  }

}
