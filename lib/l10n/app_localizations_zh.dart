// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

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
    return '关卡 $number';
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
  String get puzzleSolved => '谜题解开！';

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
  String get allowHints => 'Allow Hints';

  @override
  String get bestTime => '最佳时间';

  @override
  String levelsCompleted(int count, int total) {
    return '$count/$total 已完成';
  }

  @override
  String get totalTime => '总时间';

  @override
  String get averageTime => '平均';

  @override
  String get hintsUsed => '已用提示';

  @override
  String get currentStreak => '当前连续';

  @override
  String get bestStreak => '最佳连续';

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
  String get someDigitsWrong => '部分数字不正确。请再试！';

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
    return '$count 星';
  }

  @override
  String get selectLevel => '选择关卡';

  @override
  String get badges => '徽章';

  @override
  String get passAndPlay => '轮流玩 (2-4)';

  @override
  String get decodeTheLogic => '破解逻辑';

  @override
  String continueLevel(int number) {
    return '继续 (关卡 $number)';
  }

  @override
  String get selectDifficulty => '选择难度';

  @override
  String get all => '全部';

  @override
  String get completed => '已完成';

  @override
  String get locked => '已锁定';

  @override
  String get unlocked => '已解锁';

  @override
  String get theme => '主题';

  @override
  String get replayTutorial => '查看教程';

  @override
  String get version => '版本';

  @override
  String get contactUs => '联系我们';

  @override
  String get resetProgress => '重置进度';

  @override
  String get correct => '正确！';

  @override
  String get incorrect => '错误';

  @override
  String get round => '回合';

  @override
  String get player => '玩家';

  @override
  String get score => '分数';

  @override
  String get winner => '胜者';

  @override
  String get draw => '平局';

  @override
  String get players => '玩家';

  @override
  String get rounds => '回合';

  @override
  String get difficulty => '难度';

  @override
  String get operation => '运算';

  @override
  String get mixed => '混合';

  @override
  String get startGame => '开始';

  @override
  String get achievements => '成就';

  @override
  String get streak => '连续';

  @override
  String get solvedIn => '用时';

  @override
  String get seconds => '秒';

  @override
  String get noHintsUsed => '无提示';

  @override
  String get playAgain => '再玩一次';

  @override
  String get results => '结果';

  @override
  String get dailyStreak => '每日连续';

  @override
  String get giveUp => '放弃';

  @override
  String get rematch => '再赛';

  @override
  String get achievementUnlocked => '成就解锁！';

  @override
  String get noHintsAvailable => '此谜题无提示';

  @override
  String get overallProgress => '总体进度';

  @override
  String roundNumber(int number) {
    return '第 $number 回合';
  }

  @override
  String dayStreak(int count) {
    return '连续 $count 天！';
  }

  @override
  String get shareResult => '分享结果';

  @override
  String get dailyComplete => '每日挑战完成！';

  @override
  String get completeMoreLevels => '完成更多关卡以重玩';

  @override
  String get viewSolution => '查看答案';

  @override
  String get attempts => '尝试次数';

  @override
  String get close => '关闭';

  @override
  String get game => '游戏';

  @override
  String get soundEffects => '音效';

  @override
  String get hapticFeedback => '触觉反馈';

  @override
  String get dailyReminder => '每日提醒';

  @override
  String get appearance => '外观';

  @override
  String get upgradeToPro => '升级到Pro';

  @override
  String get noAds => '无广告';

  @override
  String get allThemes => '所有主题';

  @override
  String get bonusHint => '+1 额外提示';

  @override
  String get goPro => '升级Pro';

  @override
  String get proActive => 'CryptiQ Pro ✓';

  @override
  String get byDifficulty => '按难度';

  @override
  String get totalStars => '总星数';

  @override
  String get avgTime => '平均时间';

  @override
  String get enjoyingApp => '喜欢CryptiQ吗？';

  @override
  String get rateAppBody => '如果您喜欢这个应用，请花一点时间给个评价！';

  @override
  String get noThanks => '不了，谢谢';

  @override
  String get later => '以后';

  @override
  String get rateNow => '立即评价 ⭐';

  @override
  String get undo => '撤销';

  @override
  String get overview => '概览';

  @override
  String get dataCollection => '数据收集';

  @override
  String get thirdPartyServices => '第三方服务';

  @override
  String get dataStorage => '数据存储';

  @override
  String get childrenPrivacy => '儿童隐私';

  @override
  String get changes => '变更';

  @override
  String get contact => '联系方式';

  @override
  String get lastUpdated => '最后更新';

  @override
  String levelsOf(int completed, int total) {
    return '$total关中完成$completed关';
  }

  @override
  String get tutorialWelcomeTitle => '欢迎来到CryptiQ！';

  @override
  String get tutorialWelcomeBody =>
      '每个字母代表一个唯一的数字(0-9)。\n目标：找出每个字母代表哪个数字，\n使等式成立。';

  @override
  String get tutorialSelectTitle => '第1步：选择字母';

  @override
  String get tutorialSelectBody => '点击等式中的任意字母。\n它将高亮显示，表示已被选中。';

  @override
  String get tutorialAssignTitle => '第2步：分配数字';

  @override
  String get tutorialAssignBody => '使用数字键盘将数字(0-9)分配给\n所选字母。\n每个数字只能使用一次！';

  @override
  String get tutorialCheckTitle => '第3步：验证答案';

  @override
  String get tutorialCheckBody =>
      '当所有字母都有数字时，点击\"检查\"。\n错误的字母会变红 — 请更正！\n卡住时使用提示或撤销。';

  @override
  String get tutorialGoTitle => '准备就绪！';

  @override
  String get tutorialGoBody => '用更少的提示快速解题获得⭐⭐⭐！\n祝你好运，玩得开心！🧩';

  @override
  String get next => '下一步';

  @override
  String get autoFillNext => '自动选择下一个字母';

  @override
  String get onboardingWelcomeTitle => '欢迎来到CryptiQ！';

  @override
  String get onboardingWelcomeSubtitle => '破解逻辑';

  @override
  String get onboardingWelcomeBody =>
      'CryptiQ是一款密码算术谜题游戏，每个字母代表一个唯一的数字(0-9)。\n\n目标：找出每个字母对应哪个数字，使等式成立！';

  @override
  String get onboardingHowToPlay => '如何玩';

  @override
  String get onboardingSelectAssign => '选择并分配';

  @override
  String get onboardingExample => '如果 S=9, E=5, N=6, D=7\n那么 SEND = 9567';

  @override
  String get onboardingNeedHelp => '需要帮助？';

  @override
  String get onboardingDailyTitle => '每日挑战';

  @override
  String get onboardingDailySubtitle => '每天回来！';

  @override
  String get onboardingReady => '准备好了？开始！🚀';

  @override
  String get skip => '跳过';

  @override
  String get startPlaying => '开始玩';

  @override
  String playerName(int number) {
    return '玩家 $number';
  }

  @override
  String get addPlayer => '添加玩家';

  @override
  String roundsLabel(int count) {
    return '回合: $count';
  }

  @override
  String get addition => '加法 (+)';

  @override
  String get subtraction => '减法 (−)';

  @override
  String get multiply => '乘法 (×)';

  @override
  String get multiStep => '多步骤';

  @override
  String get passDevice => '请将设备传给此玩家';

  @override
  String get roundDetails => '回合详情';

  @override
  String get gaveUp => '已放弃';

  @override
  String get beatMyTime => '你能打破我的记录吗？';

  @override
  String get allLevelsFreeTitle => '全部1200关免费';

  @override
  String get allLevelsFreeBody => '没有锁定的关卡。尽情享受！';

  @override
  String get privacyOverviewBody => '我们尊重您的隐私，致力于保护您的个人信息。';

  @override
  String get privacyDataBody => '所有游戏进度使用离线存储(Hive)保存在您的设备上。我们不需要创建帐户或登录。';

  @override
  String get privacyStorageBody => '所有数据（进度、设置、成就）都保存在本地。卸载应用将删除所有本地数据。';

  @override
  String get privacyChangesBody => '我们可能会更新此政策。更改后继续使用即表示接受。';

  @override
  String privacyContactBody(String email) {
    return '如有疑问，请发送电子邮件: $email';
  }

  @override
  String get multiStepLabel => '多步骤';

  @override
  String get stars3 => '星';

  @override
  String get onboardingHowToPlayBody =>
      '1. 点击字母选择它\n2. 点击数字(0-9)进行分配\n3. 每个字母必须有唯一的数字\n4. 长按字母清除它';

  @override
  String get onboardingHelpSubtitle => '提示和检查';

  @override
  String get onboardingHelpBody =>
      '• 点击💡提示揭示一个字母\n• 点击✓检查来验证\n• 错误的字母变红，正确的变绿\n• 使用更少的提示获得更多⭐！';

  @override
  String get onboardingDailyBody =>
      '• 每天一个新谜题\n• 每天玩来累积连续记录🔥\n• 边玩边解锁成就\n• 从简单到专家1200关 — 全部免费！';

  @override
  String get onboardingStarExample =>
      '⭐⭐⭐  无提示，快速\n⭐⭐     1-2个提示\n⭐       3+个提示';

  @override
  String usedBy(String letter) {
    return '使用者: $letter';
  }

  @override
  String get notUsed => '未使用';

  @override
  String get replayConfirmTitle => '重玩此关卡？';

  @override
  String get replayConfirmBody => '此关卡已有⭐⭐⭐。您的最佳分数将保留。';

  @override
  String get cancel => '取消';

  @override
  String get newBadge => '新';

  @override
  String get themePicker => '主题';

  @override
  String get proThemeHint => '升级Pro解锁更多主题';

  @override
  String get shareStats => '分享统计';

  @override
  String get updateAvailable => '有可用更新';

  @override
  String get updateBody => 'CryptiQ有新版本。立即更新获得最佳体验！';

  @override
  String get updateNow => '立即更新';

  @override
  String get puzzlesSolved => '已解谜题';

  @override
  String get allDone => '全部完成！';

  @override
  String hintCount(int count) {
    return '提示 ($count)';
  }

  @override
  String get incorrectTryAgain => '错误 — 再试一次！';

  @override
  String playerScored(String player, int score) {
    return '$player得了$score分';
  }

  @override
  String hintsCount(int count) {
    return '$count个提示';
  }

  @override
  String roundOf(int current, int total) {
    return '第$current/$total回合';
  }

  @override
  String get imReady => '准备好了！';

  @override
  String playerWins(String player) {
    return '$player获胜！';
  }

  @override
  String playerStatsLine(int solved, int total, String time, int hints) {
    return '$solved/$total完成 • $time • $hints个提示';
  }

  @override
  String scorePts(int score) {
    return '$score分';
  }

  @override
  String get playerNameHint => '玩家名称';

  @override
  String get multiStepNote => '多步骤谜题仅限困难/专家。难度将被忽略。';

  @override
  String percentUnlocked(String percent) {
    return '$percent% 已解锁';
  }

  @override
  String shareDailyText(String time, int streak) {
    return '我用$time完成了CryptiQ每日挑战！🔥连续$streak天！你能超越吗？\n\n#CryptiQ #每日挑战';
  }

  @override
  String get achvNoHints10Title => '敏锐的头脑';

  @override
  String get achvStreak30Title => '连胜大师';

  @override
  String get achvStreak14Desc => '14天每日连续挑战';

  @override
  String get achvPerfect50Desc => '在 50 个关卡中获得 3 颗星';

  @override
  String get achvFiveHundredLevelsTitle => '一半的路程';

  @override
  String get achvExpertMasterTitle => '专家密码学家';

  @override
  String get achvLightningDesc => '在 10 秒内解决一个谜题';

  @override
  String get achvFirstSolveDesc => '解决你的第一个难题';

  @override
  String get achvExpertMasterDesc => '完成所有专家级别';

  @override
  String get achvPerfect50Title => '完美无瑕';

  @override
  String get achvHundredLevelsDesc => '完成 100 个关卡';

  @override
  String get achvHundredStarsDesc => '获得 100 颗星';

  @override
  String get achvHardMasterDesc => '完成所有困难级别';

  @override
  String get achvHundredStarsTitle => '星际猎人';

  @override
  String get achvStreak14Title => '两周冠军';

  @override
  String get achvPerfect10Desc => '在 10 个关卡中获得 3 颗星';

  @override
  String get achvHundredLevelsTitle => '百夫长';

  @override
  String get achvHardMasterTitle => '硬化';

  @override
  String get achvLightningTitle => '快如闪电';

  @override
  String get achvTenStarsDesc => '获得 10 颗星';

  @override
  String get achvFirstSolveTitle => '第一步';

  @override
  String get achvStreak7Desc => '7天每日连续挑战';

  @override
  String get achvPerfect10Title => '完美主义者';

  @override
  String get achvMediumMasterDesc => '完成所有中等级别';

  @override
  String get achvSpeedDemonDesc => '在 15 秒内解决一个谜题';

  @override
  String get achvTenStarsTitle => '明星收藏家';

  @override
  String get achvFiftyLevelsDesc => '完成 50 个关卡';

  @override
  String get achvStreak7Title => '周战士';

  @override
  String get achvNoHints50Desc => '在没有提示的情况下解决 50 个谜题';

  @override
  String get achvMediumMasterTitle => '三分熟';

  @override
  String get achvSpeedDemonTitle => '速度恶魔';

  @override
  String get achvThousandLevelsDesc => '完成 1000 个关卡';

  @override
  String get achvFiftyLevelsTitle => '拼图爱好者';

  @override
  String get achvNoHints50Title => '纯粹的天才';

  @override
  String get achvThousandStarsDesc => '获得 1000 颗星';

  @override
  String get achvThousandLevelsTitle => '大师';

  @override
  String get achvStreak3Desc => '连续 3 天每日挑战';

  @override
  String get achvEasyMasterDesc => '完成所有简单关卡';

  @override
  String get achvNoHints10Desc => '在没有提示的情况下解决 10 个谜题';

  @override
  String get achvStreak100Title => '势不可挡';

  @override
  String get achvStreak3Title => '滚滚而来';

  @override
  String get achvThousandStarsTitle => '星座';

  @override
  String get achvTenLevelsTitle => '热身';

  @override
  String get achvEasyMasterTitle => '简单的豌豆';

  @override
  String get achvTenLevelsDesc => '完成 10 个关卡';

  @override
  String get achvStreak30Desc => '30天每日连续挑战';

  @override
  String get achvFiveHundredLevelsDesc => '完成 500 个关卡';

  @override
  String get achvStreak100Desc => '100天每日连续挑战';

  @override
  String get achvMultiStepFirstTitle => '连锁反应';

  @override
  String get achvMultiStepFirstDesc => '解决你的第一个多步骤难题';

  @override
  String get achvMultiStepAllDesc => '完成所有 200 个多步骤谜题';

  @override
  String get achvMultiStepAllTitle => '层叠王';
}
