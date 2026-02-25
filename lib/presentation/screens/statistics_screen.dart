import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../data/datasources/local_database.dart';
import '../../levels/puzzle_generator.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = LocalDatabase.instance;
    final allProgress = db.getAllProgress();
    final completed = allProgress.where((p) => p.isCompleted).length;
    final totalStars = allProgress.fold(0, (sum, p) => sum + p.stars);
    final maxStars = PuzzleGenerator.totalPuzzles * 3;
    final totalTime = allProgress.fold(0, (sum, p) => sum + p.bestTimeSeconds);
    final avgTime = completed > 0 ? totalTime ~/ completed : 0;
    final totalHints = allProgress.fold(0, (sum, p) => sum + p.hintsUsed);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () { if (context.canPop()) { context.pop(); } else { context.go('/'); } },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: AppTheme.glassDecoration(borderRadius: 12),
                        child: const Icon(Icons.arrow_back_rounded,
                            color: Colors.white, size: 22),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Statistics',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Progress card
                    _buildProgressCard(completed, PuzzleGenerator.totalPuzzles),
                    SizedBox(height: 16),

                    // Stats grid
                    Row(
                      children: [
                        Expanded(child: _buildStatCard(
                          Icons.star_rounded,
                          '$totalStars/$maxStars',
                          'Total Stars',
                          AppTheme.primaryColor,
                        )),
                        const SizedBox(width: 12),
                        Expanded(child: _buildStatCard(
                          Icons.timer_outlined,
                          _formatTime(avgTime),
                          'Avg. Time',
                          AppTheme.mediumColor,
                        )),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildStatCard(
                          Icons.lightbulb_outline,
                          '$totalHints',
                          'Hints Used',
                          AppTheme.hardColor,
                        )),
                        const SizedBox(width: 12),
                        Expanded(child: _buildStatCard(
                          Icons.access_time_rounded,
                          _formatTime(totalTime),
                          'Total Time',
                          AppTheme.expertColor,
                        )),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Difficulty breakdown
                    const Text(
                      'By Difficulty',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDifficultyRow('Easy', 1, 100, AppTheme.easyColor, allProgress),
                    const SizedBox(height: 8),
                    _buildDifficultyRow('Medium', 101, 250, AppTheme.mediumColor, allProgress),
                    const SizedBox(height: 8),
                    _buildDifficultyRow('Hard', 251, 400, AppTheme.hardColor, allProgress),
                    const SizedBox(height: 8),
                    _buildDifficultyRow('Expert', 401, 500, AppTheme.expertColor, allProgress),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressCard(int completed, int total) {
    final progress = total > 0 ? completed / total : 0.0;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.glassDecoration(borderRadius: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Overall Progress',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
              ShaderMask(
                shaderCallback: (bounds) => AppTheme.goldGradient.createShader(bounds),
                child: Text(
                  '${(progress * 100).toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppTheme.surfaceColor,
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$completed of $total levels completed',
            style: TextStyle(fontSize: 12, color: AppTheme.textSecondary.withValues(alpha: 0.7)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.glassDecoration(borderRadius: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
          const SizedBox(height: 2),
          Text(label,
              style: TextStyle(fontSize: 12, color: AppTheme.textSecondary.withValues(alpha: 0.7))),
        ],
      ),
    );
  }

  Widget _buildDifficultyRow(String name, int start, int end, Color color, List allProgress) {
    final completed = allProgress
        .where((p) => p.levelNumber >= start && p.levelNumber <= end && p.isCompleted)
        .length;
    final total = end - start + 1;
    final progress = total > 0 ? completed / total : 0.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: AppTheme.glassDecoration(borderRadius: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 60,
            child: Text(name,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white)),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: AppTheme.surfaceColor,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 6,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text('$completed/$total',
              style: TextStyle(fontSize: 12, color: AppTheme.textSecondary.withValues(alpha: 0.8))),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    if (seconds < 60) return '${seconds}s';
    if (seconds < 3600) return '${seconds ~/ 60}m ${seconds % 60}s';
    return '${seconds ~/ 3600}h ${(seconds % 3600) ~/ 60}m';
  }
}
