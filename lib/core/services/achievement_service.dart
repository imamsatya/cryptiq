import '../../data/datasources/local_database.dart';
import '../services/daily_challenge_service.dart';

/// Achievement definition
class Achievement {
  final String id;
  final String Function(dynamic l10n) getTitle;
  final String Function(dynamic l10n) getDescription;
  final String icon; // emoji
  final bool Function(AchievementData data) check;

  const Achievement({
    required this.id,
    required this.getTitle,
    required this.getDescription,
    required this.icon,
    required this.check,
  });
}

/// Data snapshot passed to achievement checks
class AchievementData {
  final int completedLevels;
  final int totalStars;
  final int streak;
  final int fastestTime; // best time across all levels
  final int noHintLevels; // levels solved with 0 hints
  final int perfectLevels; // levels with 3 stars
  final int easyCompleted;
  final int mediumCompleted;
  final int hardCompleted;
  final int expertCompleted;
  final int multiStepCompleted; // levels 1001-1200
  final int totalAttempts;

  const AchievementData({
    required this.completedLevels,
    required this.totalStars,
    required this.streak,
    required this.fastestTime,
    required this.noHintLevels,
    required this.perfectLevels,
    required this.easyCompleted,
    required this.mediumCompleted,
    required this.hardCompleted,
    required this.expertCompleted,
    required this.multiStepCompleted,
    required this.totalAttempts,
  });
}

/// Service that defines, checks, and tracks achievements
class AchievementService {
  AchievementService._();
  static final instance = AchievementService._();

  static const _unlockedKey = 'achievements_unlocked';

  final _db = LocalDatabase.instance;

  /// All achievement definitions
  static final List<Achievement> achievements = [
    // --- Progression ---
    Achievement(
      id: 'first_solve',
      getTitle: (l10n) => l10n.achvFirstSolveTitle,
      getDescription: (l10n) => l10n.achvFirstSolveDesc,
      icon: '🎯',
      check: (d) => d.completedLevels >= 1,
    ),
    Achievement(
      id: 'ten_levels',
      getTitle: (l10n) => l10n.achvTenLevelsTitle,
      getDescription: (l10n) => l10n.achvTenLevelsDesc,
      icon: '🔥',
      check: (d) => d.completedLevels >= 10,
    ),
    Achievement(
      id: 'fifty_levels',
      getTitle: (l10n) => l10n.achvFiftyLevelsTitle,
      getDescription: (l10n) => l10n.achvFiftyLevelsDesc,
      icon: '💪',
      check: (d) => d.completedLevels >= 50,
    ),
    Achievement(
      id: 'hundred_levels',
      getTitle: (l10n) => l10n.achvHundredLevelsTitle,
      getDescription: (l10n) => l10n.achvHundredLevelsDesc,
      icon: '🏅',
      check: (d) => d.completedLevels >= 100,
    ),
    Achievement(
      id: 'five_hundred_levels',
      getTitle: (l10n) => l10n.achvFiveHundredLevelsTitle,
      getDescription: (l10n) => l10n.achvFiveHundredLevelsDesc,
      icon: '🌟',
      check: (d) => d.completedLevels >= 500,
    ),
    Achievement(
      id: 'thousand_levels',
      getTitle: (l10n) => l10n.achvThousandLevelsTitle,
      getDescription: (l10n) => l10n.achvThousandLevelsDesc,
      icon: '👑',
      check: (d) => d.completedLevels >= 1000,
    ),

    // --- Stars ---
    Achievement(
      id: 'ten_stars',
      getTitle: (l10n) => l10n.achvTenStarsTitle,
      getDescription: (l10n) => l10n.achvTenStarsDesc,
      icon: '⭐',
      check: (d) => d.totalStars >= 10,
    ),
    Achievement(
      id: 'hundred_stars',
      getTitle: (l10n) => l10n.achvHundredStarsTitle,
      getDescription: (l10n) => l10n.achvHundredStarsDesc,
      icon: '🌠',
      check: (d) => d.totalStars >= 100,
    ),
    Achievement(
      id: 'thousand_stars',
      getTitle: (l10n) => l10n.achvThousandStarsTitle,
      getDescription: (l10n) => l10n.achvThousandStarsDesc,
      icon: '✨',
      check: (d) => d.totalStars >= 1000,
    ),

    // --- Speed ---
    Achievement(
      id: 'speed_demon',
      getTitle: (l10n) => l10n.achvSpeedDemonTitle,
      getDescription: (l10n) => l10n.achvSpeedDemonDesc,
      icon: '⚡',
      check: (d) => d.fastestTime > 0 && d.fastestTime <= 15,
    ),
    Achievement(
      id: 'lightning',
      getTitle: (l10n) => l10n.achvLightningTitle,
      getDescription: (l10n) => l10n.achvLightningDesc,
      icon: '🏎️',
      check: (d) => d.fastestTime > 0 && d.fastestTime <= 10,
    ),

    // --- No Hints ---
    Achievement(
      id: 'no_hints_10',
      getTitle: (l10n) => l10n.achvNoHints10Title,
      getDescription: (l10n) => l10n.achvNoHints10Desc,
      icon: '🧠',
      check: (d) => d.noHintLevels >= 10,
    ),
    Achievement(
      id: 'no_hints_50',
      getTitle: (l10n) => l10n.achvNoHints50Title,
      getDescription: (l10n) => l10n.achvNoHints50Desc,
      icon: '🎓',
      check: (d) => d.noHintLevels >= 50,
    ),

    // --- Perfect ---
    Achievement(
      id: 'perfect_10',
      getTitle: (l10n) => l10n.achvPerfect10Title,
      getDescription: (l10n) => l10n.achvPerfect10Desc,
      icon: '💎',
      check: (d) => d.perfectLevels >= 10,
    ),
    Achievement(
      id: 'perfect_50',
      getTitle: (l10n) => l10n.achvPerfect50Title,
      getDescription: (l10n) => l10n.achvPerfect50Desc,
      icon: '🏆',
      check: (d) => d.perfectLevels >= 50,
    ),

    // --- Difficulty tiers ---
    Achievement(
      id: 'easy_master',
      getTitle: (l10n) => l10n.achvEasyMasterTitle,
      getDescription: (l10n) => l10n.achvEasyMasterDesc,
      icon: '🟢',
      check: (d) => d.easyCompleted >= 250,
    ),
    Achievement(
      id: 'medium_master',
      getTitle: (l10n) => l10n.achvMediumMasterTitle,
      getDescription: (l10n) => l10n.achvMediumMasterDesc,
      icon: '🟡',
      check: (d) => d.mediumCompleted >= 250,
    ),
    Achievement(
      id: 'hard_master',
      getTitle: (l10n) => l10n.achvHardMasterTitle,
      getDescription: (l10n) => l10n.achvHardMasterDesc,
      icon: '🟠',
      check: (d) => d.hardCompleted >= 250,
    ),
    Achievement(
      id: 'expert_master',
      getTitle: (l10n) => l10n.achvExpertMasterTitle,
      getDescription: (l10n) => l10n.achvExpertMasterDesc,
      icon: '🔴',
      check: (d) => d.expertCompleted >= 450,
    ),

    // --- Daily streak ---
    Achievement(
      id: 'streak_3',
      getTitle: (l10n) => l10n.achvStreak3Title,
      getDescription: (l10n) => l10n.achvStreak3Desc,
      icon: '🔥',
      check: (d) => d.streak >= 3,
    ),
    Achievement(
      id: 'streak_7',
      getTitle: (l10n) => l10n.achvStreak7Title,
      getDescription: (l10n) => l10n.achvStreak7Desc,
      icon: '📅',
      check: (d) => d.streak >= 7,
    ),
    Achievement(
      id: 'streak_14',
      getTitle: (l10n) => l10n.achvStreak14Title,
      getDescription: (l10n) => l10n.achvStreak14Desc,
      icon: '🏅',
      check: (d) => d.streak >= 14,
    ),
    Achievement(
      id: 'streak_30',
      getTitle: (l10n) => l10n.achvStreak30Title,
      getDescription: (l10n) => l10n.achvStreak30Desc,
      icon: '🗓️',
      check: (d) => d.streak >= 30,
    ),
    Achievement(
      id: 'streak_100',
      getTitle: (l10n) => l10n.achvStreak100Title,
      getDescription: (l10n) => l10n.achvStreak100Desc,
      icon: '💯',
      check: (d) => d.streak >= 100,
    ),

    // --- Multi-step ---
    Achievement(
      id: 'multi_step_first',
      getTitle: (l10n) => l10n.achvMultiStepFirstTitle,
      getDescription: (l10n) => l10n.achvMultiStepFirstDesc,
      icon: '🔗',
      check: (d) => d.multiStepCompleted >= 1,
    ),
    Achievement(
      id: 'multi_step_all',
      getTitle: (l10n) => l10n.achvMultiStepAllTitle,
      getDescription: (l10n) => l10n.achvMultiStepAllDesc,
      icon: '🌊',
      check: (d) => d.multiStepCompleted >= 200,
    ),
  ];

  /// Build current achievement data from DB
  AchievementData _buildData() {
    final all = _db.getAllProgress();
    final completed = all.where((p) => p.isCompleted).toList();
    final streak = DailyChallengeService.instance.streak;

    int fastest = 0;
    int noHint = 0;
    int perfect = 0;
    int easy = 0, medium = 0, hard = 0, expert = 0, multi = 0;
    int totalAttempts = 0;

    for (final p in completed) {
      if (fastest == 0 || p.bestTimeSeconds < fastest) {
        fastest = p.bestTimeSeconds;
      }
      if (p.totalHintsUsed == 0) noHint++;
      if (p.stars == 3) perfect++;
      totalAttempts += p.attempts;

      final lv = p.levelNumber;
      if (lv >= 1 && lv <= 250) {
        easy++;
      } else if (lv >= 251 && lv <= 500) {
        medium++;
      } else if (lv >= 501 && lv <= 750) {
        hard++;
      } else if (lv >= 751 && lv <= 1200) {
        expert++;
      }
      if (lv >= 1001 && lv <= 1200) {
        multi++;
      }
    }

    return AchievementData(
      completedLevels: completed.length,
      totalStars: all.fold(0, (s, p) => s + p.stars),
      streak: streak,
      fastestTime: fastest,
      noHintLevels: noHint,
      perfectLevels: perfect,
      easyCompleted: easy,
      mediumCompleted: medium,
      hardCompleted: hard,
      expertCompleted: expert,
      multiStepCompleted: multi,
      totalAttempts: totalAttempts,
    );
  }

  /// Get set of unlocked achievement IDs from Hive
  Set<String> get _unlocked {
    final list = _db.settingsBox.get(_unlockedKey, defaultValue: <String>[]);
    return Set<String>.from(list as List);
  }

  /// Save unlocked set
  Future<void> _saveUnlocked(Set<String> ids) async {
    await _db.settingsBox.put(_unlockedKey, ids.toList());
  }

  /// Check all achievements, return newly unlocked ones
  Future<List<Achievement>> checkAndUnlock() async {
    final data = _buildData();
    final unlocked = _unlocked;
    final newlyUnlocked = <Achievement>[];

    for (final a in achievements) {
      if (!unlocked.contains(a.id) && a.check(data)) {
        unlocked.add(a.id);
        newlyUnlocked.add(a);
      }
    }

    if (newlyUnlocked.isNotEmpty) {
      await _saveUnlocked(unlocked);
    }

    return newlyUnlocked;
  }

  /// Get all achievements with their unlock status
  List<(Achievement, bool)> getAll() {
    final unlocked = _unlocked;
    return achievements.map((a) => (a, unlocked.contains(a.id))).toList();
  }

  /// Count unlocked
  int get unlockedCount => _unlocked.length;
  int get totalCount => achievements.length;
}
