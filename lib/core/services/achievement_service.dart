import '../../data/datasources/local_database.dart';
import '../services/daily_challenge_service.dart';

/// Achievement definition
class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon; // emoji
  final bool Function(AchievementData data) check;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
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
      title: 'First Steps',
      description: 'Solve your first puzzle',
      icon: '🎯',
      check: (d) => d.completedLevels >= 1,
    ),
    Achievement(
      id: 'ten_levels',
      title: 'Getting Warmed Up',
      description: 'Complete 10 levels',
      icon: '🔥',
      check: (d) => d.completedLevels >= 10,
    ),
    Achievement(
      id: 'fifty_levels',
      title: 'Puzzle Enthusiast',
      description: 'Complete 50 levels',
      icon: '💪',
      check: (d) => d.completedLevels >= 50,
    ),
    Achievement(
      id: 'hundred_levels',
      title: 'Centurion',
      description: 'Complete 100 levels',
      icon: '🏅',
      check: (d) => d.completedLevels >= 100,
    ),
    Achievement(
      id: 'five_hundred_levels',
      title: 'Half Way There',
      description: 'Complete 500 levels',
      icon: '🌟',
      check: (d) => d.completedLevels >= 500,
    ),
    Achievement(
      id: 'thousand_levels',
      title: 'Grand Master',
      description: 'Complete 1000 levels',
      icon: '👑',
      check: (d) => d.completedLevels >= 1000,
    ),

    // --- Stars ---
    Achievement(
      id: 'ten_stars',
      title: 'Star Collector',
      description: 'Earn 10 stars',
      icon: '⭐',
      check: (d) => d.totalStars >= 10,
    ),
    Achievement(
      id: 'hundred_stars',
      title: 'Star Hunter',
      description: 'Earn 100 stars',
      icon: '🌠',
      check: (d) => d.totalStars >= 100,
    ),
    Achievement(
      id: 'thousand_stars',
      title: 'Constellation',
      description: 'Earn 1000 stars',
      icon: '✨',
      check: (d) => d.totalStars >= 1000,
    ),

    // --- Speed ---
    Achievement(
      id: 'speed_demon',
      title: 'Speed Demon',
      description: 'Solve a puzzle in under 15 seconds',
      icon: '⚡',
      check: (d) => d.fastestTime > 0 && d.fastestTime <= 15,
    ),
    Achievement(
      id: 'lightning',
      title: 'Lightning Fast',
      description: 'Solve a puzzle in under 10 seconds',
      icon: '🏎️',
      check: (d) => d.fastestTime > 0 && d.fastestTime <= 10,
    ),

    // --- No Hints ---
    Achievement(
      id: 'no_hints_10',
      title: 'Sharp Mind',
      description: 'Solve 10 puzzles without hints',
      icon: '🧠',
      check: (d) => d.noHintLevels >= 10,
    ),
    Achievement(
      id: 'no_hints_50',
      title: 'Pure Genius',
      description: 'Solve 50 puzzles without hints',
      icon: '🎓',
      check: (d) => d.noHintLevels >= 50,
    ),

    // --- Perfect ---
    Achievement(
      id: 'perfect_10',
      title: 'Perfectionist',
      description: 'Get 3 stars on 10 levels',
      icon: '💎',
      check: (d) => d.perfectLevels >= 10,
    ),
    Achievement(
      id: 'perfect_50',
      title: 'Flawless',
      description: 'Get 3 stars on 50 levels',
      icon: '🏆',
      check: (d) => d.perfectLevels >= 50,
    ),

    // --- Difficulty tiers ---
    Achievement(
      id: 'easy_master',
      title: 'Easy Peasy',
      description: 'Complete all Easy levels',
      icon: '🟢',
      check: (d) => d.easyCompleted >= 250,
    ),
    Achievement(
      id: 'medium_master',
      title: 'Medium Rare',
      description: 'Complete all Medium levels',
      icon: '🟡',
      check: (d) => d.mediumCompleted >= 250,
    ),
    Achievement(
      id: 'hard_master',
      title: 'Hardened',
      description: 'Complete all Hard levels',
      icon: '🟠',
      check: (d) => d.hardCompleted >= 250,
    ),
    Achievement(
      id: 'expert_master',
      title: 'Expert Cryptographer',
      description: 'Complete all Expert levels',
      icon: '🔴',
      check: (d) => d.expertCompleted >= 450,
    ),

    // --- Daily streak ---
    Achievement(
      id: 'streak_3',
      title: 'On a Roll',
      description: '3 day daily challenge streak',
      icon: '🔥',
      check: (d) => d.streak >= 3,
    ),
    Achievement(
      id: 'streak_7',
      title: 'Week Warrior',
      description: '7 day daily challenge streak',
      icon: '📅',
      check: (d) => d.streak >= 7,
    ),
    Achievement(
      id: 'streak_30',
      title: 'Streak Master',
      description: '30 day daily challenge streak',
      icon: '🗓️',
      check: (d) => d.streak >= 30,
    ),

    // --- Multi-step ---
    Achievement(
      id: 'multi_step_first',
      title: 'Chain Reaction',
      description: 'Solve your first multi-step puzzle',
      icon: '🔗',
      check: (d) => d.multiStepCompleted >= 1,
    ),
    Achievement(
      id: 'multi_step_all',
      title: 'Cascade King',
      description: 'Complete all 200 multi-step puzzles',
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
      if (p.hintsUsed == 0) noHint++;
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
