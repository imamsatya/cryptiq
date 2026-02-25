import '../../domain/entities/user_progress.dart';
import '../../core/constants/app_constants.dart';
import '../datasources/local_database.dart';

/// Repository for managing user progress data
class ProgressRepository {
  final LocalDatabase _db = LocalDatabase.instance;

  UserProgress? getProgress(int levelNumber) => _db.getProgress(levelNumber);

  Future<void> saveProgress(UserProgress progress) => _db.saveProgress(progress);

  List<UserProgress> getAllProgress() => _db.getAllProgress();

  int getCompletedLevelsCount() => _db.getCompletedLevelsCount();

  int getTotalStars() => _db.getTotalStars();

  int getLastPlayedLevel() => _db.getLastPlayedLevel();

  Future<void> setLastPlayedLevel(int level) => _db.setLastPlayedLevel(level);

  /// Calculate stars based on cumulative totalHintsUsed
  static int calculateStarsFromHints(int totalHintsUsed) {
    if (totalHintsUsed <= AppConstants.threeStarMaxHints) return 3;
    if (totalHintsUsed <= AppConstants.twoStarMaxHints) return 2;
    return 1;
  }

  /// Complete a level and save progress.
  /// [hintsUsed] is the hints used in THIS attempt — accumulated permanently.
  Future<UserProgress> completeLevel({
    required int levelNumber,
    required int timeSeconds,
    required int hintsUsed,
  }) async {
    final existing = _db.getProgress(levelNumber);

    if (existing != null && existing.isCompleted) {
      // Replay: accumulate hints, update best time, increment attempts
      existing.totalHintsUsed += hintsUsed;
      existing.attempts += 1;
      if (timeSeconds < existing.bestTimeSeconds) {
        existing.bestTimeSeconds = timeSeconds;
      }
      // Recalculate stars from cumulative hints
      existing.stars = calculateStarsFromHints(existing.totalHintsUsed);
      await _db.saveProgress(existing);
      return existing;
    }

    // First completion
    final totalHints = (existing?.totalHintsUsed ?? 0) + hintsUsed;
    final stars = calculateStarsFromHints(totalHints);

    final progress = UserProgress(
      levelNumber: levelNumber,
      isCompleted: true,
      stars: stars,
      bestTimeSeconds: timeSeconds,
      totalHintsUsed: totalHints,
      attempts: (existing?.attempts ?? 0) + 1,
      completedAt: DateTime.now(),
    );

    await _db.saveProgress(progress);
    await _db.setLastPlayedLevel(levelNumber);
    return progress;
  }
}
