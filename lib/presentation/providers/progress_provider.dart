import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local_database.dart';
import '../../data/repositories/progress_repository.dart';
import '../../domain/entities/user_progress.dart';

/// Provider for user progress
final progressRepositoryProvider = Provider<ProgressRepository>((ref) {
  return ProgressRepository();
});

/// Provider for completed levels count
final completedLevelsProvider = StateProvider<int>((ref) {
  return LocalDatabase.instance.getCompletedLevelsCount();
});

/// Provider for total stars
final totalStarsProvider = StateProvider<int>((ref) {
  return LocalDatabase.instance.getTotalStars();
});

/// Provider for last played level
final lastPlayedLevelProvider = StateProvider<int>((ref) {
  return LocalDatabase.instance.getLastPlayedLevel();
});

/// Provider for getting individual level progress
final levelProgressProvider = Provider.family<UserProgress?, int>((ref, levelNumber) {
  return LocalDatabase.instance.getProgress(levelNumber);
});

/// Provider for pro status
final proStatusProvider = StateProvider<bool>((ref) {
  return LocalDatabase.instance.getProStatus();
});

/// Provider for settings
final soundEnabledProvider = StateProvider<bool>((ref) {
  return LocalDatabase.instance.getSoundEnabled();
});

final hapticsEnabledProvider = StateProvider<bool>((ref) {
  return LocalDatabase.instance.getHapticsEnabled();
});
