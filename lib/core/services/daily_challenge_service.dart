import 'notification_service.dart';
import 'dart:math';
import '../../data/datasources/local_database.dart';
import '../../levels/puzzle_generator.dart';
import '../../domain/entities/puzzle.dart';

/// Service that manages daily challenge puzzle selection and streak tracking.
///
/// Each day gets a deterministic puzzle based on date seed.
/// Progress is stored in Hive settings box.
class DailyChallengeService {
  DailyChallengeService._();
  static final instance = DailyChallengeService._();

  static const _completedDateKey = 'daily_completed_date';
  static const _bestTimeKey = 'daily_best_time';
  static const _streakKey = 'daily_streak';
  static const _bestStreakKey = 'daily_best_streak';
  static const _lastStreakDateKey = 'daily_last_streak_date';
  static const _completedDatesKey = 'daily_completed_dates';

  final _db = LocalDatabase.instance;

  /// Get today's date string (yyyy-MM-dd)
  String get _today {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  String get _yesterday {
    final y = DateTime.now().subtract(const Duration(days: 1));
    return '${y.year}-${y.month.toString().padLeft(2, '0')}-${y.day.toString().padLeft(2, '0')}';
  }

  /// Get today's daily challenge puzzle.
  /// Uses date as seed → same puzzle for everyone on the same day.
  CryptarithmPuzzle getDailyPuzzle() {
    final now = DateTime.now();
    // Seed from date: days since epoch
    final daysSinceEpoch = now.difference(DateTime(2024, 1, 1)).inDays;
    final rng = Random(daysSinceEpoch * 7 + 42);

    // Pick from medium-hard range (levels 251-1000) for interesting puzzles
    // Avoid easy (too trivial) and multi-step (too complex for daily)
    final levelNum = 251 + rng.nextInt(750); // 251-1000
    return PuzzleGenerator.getPuzzle(levelNum);
  }

  /// Whether today's daily challenge has been completed
  bool get isTodayCompleted {
    final completed = _db.settingsBox.get(_completedDateKey, defaultValue: '');
    return completed == _today;
  }

  /// Best time for today's challenge (0 if not completed)
  int get todayBestTime {
    if (!isTodayCompleted) return 0;
    return _db.settingsBox.get(_bestTimeKey, defaultValue: 0);
  }

  /// Current streak count (validates if streak is still active)
  int get streak {
    final lastDate = _db.settingsBox.get(_lastStreakDateKey, defaultValue: '');
    final currentStreak = _db.settingsBox.get(_streakKey, defaultValue: 0);

    // Streak is valid if last completion was today or yesterday
    if (lastDate == _today || lastDate == _yesterday) {
      return currentStreak;
    }

    // Streak broken — return 0 (will be reset on next completion)
    return 0;
  }

  /// Best streak ever achieved
  int get bestStreak {
    return _db.settingsBox.get(_bestStreakKey, defaultValue: 0);
  }

  /// Get all completed dates (as date strings yyyy-MM-dd)
  List<String> get completedDates {
    final dates = _db.settingsBox.get(_completedDatesKey, defaultValue: <String>[]);
    return List<String>.from(dates);
  }

  /// Complete today's daily challenge
  Future<void> completeDaily(int timeSeconds) async {
    final wasCompleted = isTodayCompleted;
    final currentBest = todayBestTime;

    // Save completion
    await _db.settingsBox.put(_completedDateKey, _today);

    // Track completed dates history
    if (!wasCompleted) {
      final dates = completedDates;
      if (!dates.contains(_today)) {
        dates.add(_today);
        await _db.settingsBox.put(_completedDatesKey, dates);
      }
    }

    // Update best time
    if (!wasCompleted || timeSeconds < currentBest) {
      await _db.settingsBox.put(_bestTimeKey, timeSeconds);
    }

    // Update streak
    if (!wasCompleted) {
      final lastDate = _db.settingsBox.get(_lastStreakDateKey, defaultValue: '');

      int newStreak;
      if (lastDate == _yesterday) {
        // Consecutive day → increment streak
        newStreak = (_db.settingsBox.get(_streakKey, defaultValue: 0) as int) + 1;
      } else if (lastDate == _today) {
        // Already counted today
        newStreak = _db.settingsBox.get(_streakKey, defaultValue: 0);
      } else {
        // Streak broken → restart at 1
        newStreak = 1;
      }

      await _db.settingsBox.put(_streakKey, newStreak);
      await _db.settingsBox.put(_lastStreakDateKey, _today);

      // Cancel today's notification since challenge completed
      NotificationService.instance.cancelDailyReminder();

      // Update best streak
      final currentBestStreak = _db.settingsBox.get(_bestStreakKey, defaultValue: 0) as int;
      if (newStreak > currentBestStreak) {
        await _db.settingsBox.put(_bestStreakKey, newStreak);
      }
    }
  }
}

