import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for zh (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([super.locale = 'zh']);

  @override
  String get appTitle => 'CryptiQ';

  @override
  String get play => '开始';

  @override
  String get dailyChallenge => '每日挑战';

  @override
  String get statistics => '统计';

  @override
  String get settings => '设置';

  @override
  String level(int number) {
    return '关卡 {number}';
  }

  @override
  String get easy => '简单';

  @override
  String get medium => '中等';

  @override
  String get hard => '困难';

  @override
  String get expert => '专家';

  @override
  String get hint => '提示';

  @override
  String get check => '检查';

  @override
  String get clear => '清除';

  @override
  String get clearAll => '全部清除';

  @override
  String get congratulations => '恭喜！';

  @override
  String get puzzleSolved => '谜题已解！';

  @override
  String get nextLevel => '下一关';

  @override
  String get replay => '重玩';

  @override
  String get share => '分享';

  @override
  String get time => '时间';

  @override
  String get hints => '提示';

  @override
  String get bestTime => '最佳时间';

  @override
  String get levelsCompleted => '已完成关卡';

  @override
  String get totalTime => '总时间';

  @override
  String get averageTime => '平均时间';

  @override
  String get hintsUsed => '已用提示';

  @override
  String get currentStreak => '当前连胜';

  @override
  String get bestStreak => '最佳连胜';

  @override
  String get sound => '声音';

  @override
  String get haptics => '震动';

  @override
  String get language => '语言';

  @override
  String get about => '关于';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get rateApp => '评价应用';

  @override
  String get removeAds => '移除广告';

  @override
  String get restorePurchase => '恢复购买';

  @override
  String get tryAgain => '再试一次';

  @override
  String get wrongAnswer => '答案错误';

  @override
  String get someDigitsWrong => '部分数字不正确，请再试一次！';

  @override
  String get allLevelsFree => '所有关卡免费！';

  @override
  String get noLockedLevels => '没有锁定的关卡。';

  @override
  String get home => '主页';

  @override
  String get back => '返回';

  @override
  String get resume => '继续';

  @override
  String stars(int count) {
    return '{count} 星';
  }

}
