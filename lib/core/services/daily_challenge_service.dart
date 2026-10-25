import 'notification_service.dart';
import 'dart:math';
import 'package:flutter/foundation.dart';
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
  static const _lastReviveDateKey = 'daily_last_revive_date';
  static const _reviveDismissedDateKey = 'daily_revive_dismissed_date';

  /// Smallest streak worth offering to revive, and how often a revive is allowed.
  static const minRevivableStreak = 2;
  static const reviveCooldownDays = 7;

  final _db = LocalDatabase.instance;

  /// Current time; replaced in tests.
  @visibleForTesting
  DateTime Function() clock = DateTime.now;

  /// Date string (yyyy-MM-dd) of [d]'s calendar day
  static String dateKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  /// Calendar day before [now]. Not `subtract(Duration(days: 1))`: on a
  /// daylight-saving change a day is 23 or 25 hours long.
  static String yesterdayKey(DateTime now) =>
      dateKey(DateTime(now.year, now.month, now.day - 1));

  /// Days from 2024-01-01 to [now]'s calendar date. Counted on UTC dates so
  /// a daylight-saving change can't make it one day short near midnight.
  static int dayNumber(DateTime now) =>
      DateTime.utc(now.year, now.month, now.day)
          .difference(DateTime.utc(2024, 1, 1))
          .inDays;

  /// Get today's date string (yyyy-MM-dd)
  String get _today => dateKey(clock());

  String get _yesterday => yesterdayKey(clock());

  /// Get today's daily challenge puzzle.
  /// Uses date as seed → same puzzle for everyone on the same day.
  CryptarithmPuzzle getDailyPuzzle() {
    // Seed from date: days since epoch
    final daysSinceEpoch = dayNumber(clock());
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

      // Today is done: move the reminder to tomorrow (cancelling it left no
      // reminder at all on the next day the user forgot to open the app)
      NotificationService.instance.scheduleDailyReminder();

      // Update best streak
      final currentBestStreak = _db.settingsBox.get(_bestStreakKey, defaultValue: 0) as int;
      if (newStreak > currentBestStreak) {
        await _db.settingsBox.put(_bestStreakKey, newStreak);
      }
    }
  }

  // ==========  REVIVE STREAK  ==========

  /// The streak that can be restored today, or 0 if there is none.
  ///
  /// Only when exactly one day was missed (the last completion was the day
  /// before yesterday), today's challenge isn't done yet — completing it would
  /// restart the streak at 1 — and no revive was used in the last
  /// [reviveCooldownDays] days.
  int get revivableStreak {
    final now = clock();
    final dayBeforeYesterday = dateKey(DateTime(now.year, now.month, now.day - 2));
    final lastDate = _db.settingsBox.get(_lastStreakDateKey, defaultValue: '');
    final stored = _db.settingsBox.get(_streakKey, defaultValue: 0) as int;
    if (lastDate != dayBeforeYesterday || isTodayCompleted) return 0;
    if (stored < minRevivableStreak) return 0;

    final lastRevive = _db.settingsBox.get(_lastReviveDateKey, defaultValue: '') as String;
    if (lastRevive.isNotEmpty) {
      final daysSince = dayNumber(now) - dayNumber(DateTime.parse(lastRevive));
      if (daysSince < reviveCooldownDays) return 0;
    }
    return stored;
  }

  /// Whether to offer the revive now (not after the user declined it today).
  bool get shouldOfferRevive =>
      revivableStreak > 0 &&
      _db.settingsBox.get(_reviveDismissedDateKey, defaultValue: '') != _today;

  /// User declined the offer: don't ask again today.
  Future<void> dismissRevive() => _db.settingsBox.put(_reviveDismissedDateKey, _today);

  /// Restores the streak by treating yesterday as played. Yesterday is not
  /// added to the completed-days calendar: the puzzle wasn't actually solved.
  Future<bool> reviveStreak() async {
    if (revivableStreak == 0) return false;
    await _db.settingsBox.put(_lastStreakDateKey, _yesterday);
    await _db.settingsBox.put(_lastReviveDateKey, _today);
    NotificationService.instance.scheduleDailyReminder(); // streak text again
    return true;
  }
}

