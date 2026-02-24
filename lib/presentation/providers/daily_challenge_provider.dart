import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/daily_challenge_service.dart';
import '../../domain/entities/puzzle.dart';
import 'game_state_provider.dart';

/// Provider for the daily challenge puzzle
final dailyPuzzleProvider = Provider<CryptarithmPuzzle>((ref) {
  return DailyChallengeService.instance.getDailyPuzzle();
});

/// Provider for whether today's challenge is completed
final dailyCompletedProvider = StateProvider<bool>((ref) {
  return DailyChallengeService.instance.isTodayCompleted;
});

/// Provider for daily streak count
final dailyStreakProvider = StateProvider<int>((ref) {
  return DailyChallengeService.instance.streak;
});

/// Provider for today's best time
final dailyBestTimeProvider = StateProvider<int>((ref) {
  return DailyChallengeService.instance.todayBestTime;
});

/// Game state provider for daily challenge (uses level -1 as key)
final dailyGameStateProvider = StateNotifierProvider.autoDispose<GameStateNotifier, GameState>(
  (ref) {
    final puzzle = DailyChallengeService.instance.getDailyPuzzle();
    // No progress saving for daily (we handle it separately)
    return GameStateNotifier(puzzle, null);
  },
);
