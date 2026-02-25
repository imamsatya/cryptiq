import 'package:hive/hive.dart';

part 'user_progress.g.dart';

@HiveType(typeId: 0)
class UserProgress extends HiveObject {
  @HiveField(0)
  final int levelNumber;

  @HiveField(1)
  bool isCompleted;

  @HiveField(2)
  int stars; // 0-3

  @HiveField(3)
  int bestTimeSeconds;

  @HiveField(4)
  int totalHintsUsed; // Cumulative across ALL attempts (permanent)

  @HiveField(5)
  int attempts;

  @HiveField(6)
  DateTime? completedAt;

  UserProgress({
    required this.levelNumber,
    this.isCompleted = false,
    this.stars = 0,
    this.bestTimeSeconds = 0,
    this.totalHintsUsed = 0,
    this.attempts = 0,
    this.completedAt,
  });
}
