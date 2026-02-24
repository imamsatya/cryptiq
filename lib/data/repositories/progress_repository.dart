import '../../domain/entities/user_progress.dart';
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

  /// Complete a level and save progress
  Future<UserProgress> completeLevel({
    required int levelNumber,
    required int timeSeconds,
    required int hintsUsed,
    required int stars,
  }) async {
    final existing = _db.getProgress(levelNumber);
    
    if (existing != null && existing.isCompleted) {
      // Update only if better score
      if (stars > existing.stars || 
          (stars == existing.stars && timeSeconds < existing.bestTimeSeconds)) {
        existing.stars = stars;
        existing.bestTimeSeconds = timeSeconds;
        existing.hintsUsed = hintsUsed;
        existing.attempts += 1;
        await _db.saveProgress(existing);
        return existing;
      }
      existing.attempts += 1;
      await _db.saveProgress(existing);
      return existing;
    }

    final progress = UserProgress(
      levelNumber: levelNumber,
      isCompleted: true,
      stars: stars,
      bestTimeSeconds: timeSeconds,
      hintsUsed: hintsUsed,
      attempts: (existing?.attempts ?? 0) + 1,
      completedAt: DateTime.now(),
    );

    await _db.saveProgress(progress);
    await _db.setLastPlayedLevel(levelNumber);
    return progress;
  }
}
