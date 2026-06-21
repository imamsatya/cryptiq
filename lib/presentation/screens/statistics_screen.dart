import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../widgets/stats_card.dart';
import '../../core/theme/app_theme.dart';
import '../../data/datasources/local_database.dart';
import '../../levels/puzzle_generator.dart';
import '../../core/services/daily_challenge_service.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final _statsCardKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final db = LocalDatabase.instance;
    final allProgress = db.getAllProgress();
    final completed = allProgress.where((p) => p.isCompleted).length;
    final totalStars = allProgress.fold(0, (sum, p) => sum + p.stars);
    final maxStars = PuzzleGenerator.totalPuzzles * 3;
    final totalTime = allProgress.fold(0, (sum, p) => sum + p.bestTimeSeconds);
    final avgTime = completed > 0 ? totalTime ~/ completed : 0;
    final totalHints = allProgress.fold(0, (sum, p) => sum + p.totalHintsUsed);

    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: Stack(
          children: [
            // Offscreen stats card for image capture
            Positioned(
              left: -500,
              child: StatsCard(
                repaintKey: _statsCardKey,
                completed: completed,
                totalStars: totalStars,
                maxStars: maxStars,
                avgTime: avgTime,
                totalHints: totalHints,
                currentStreak: db.settingsBox.get('daily_streak', defaultValue: 0),
              ),
            ),
            SafeArea(
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
                    Text(
                      l10n.statistics,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => StatsCard.captureAndShare(_statsCardKey),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: AppTheme.glassDecoration(borderRadius: 12),
                        child: const Icon(Icons.share_rounded, color: Colors.white, size: 20),
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
                    _buildProgressCard(context, completed, PuzzleGenerator.totalPuzzles),
                    SizedBox(height: 16),

                    // Stats grid
                    Row(
                      children: [
                        Expanded(child: _buildStatCard(
                          Icons.star_rounded,
                          '$totalStars/$maxStars',
                          l10n.totalStars,
                          AppTheme.primaryColor,
                        )),
                        const SizedBox(width: 12),
                        Expanded(child: _buildStatCard(
                          Icons.timer_outlined,
                          _formatTime(avgTime),
                          l10n.avgTime,
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
                          l10n.hintsUsed,
                          AppTheme.hardColor,
                        )),
                        const SizedBox(width: 12),
                        Expanded(child: _buildStatCard(
                          Icons.access_time_rounded,
                          _formatTime(totalTime),
                          l10n.totalTime,
                          AppTheme.expertColor,
                        )),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Streak & Daily row
                    Row(
                      children: [
                        Expanded(child: _buildStatCard(
                          Icons.local_fire_department_rounded,
                          '${DailyChallengeService.instance.streak}',
                          l10n.currentStreak,
                          Colors.orange,
                        )),
                        const SizedBox(width: 12),
                        Expanded(child: _buildStatCard(
                          Icons.emoji_events_rounded,
                          '${DailyChallengeService.instance.bestStreak}',
                          l10n.bestStreak,
                          const Color(0xFFD4A843),
                        )),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Difficulty breakdown
                    Text(
                      l10n.byDifficulty,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDifficultyRow(l10n.easy, 1, 250, AppTheme.easyColor, allProgress),
                    const SizedBox(height: 8),
                    _buildDifficultyRow(l10n.medium, 251, 500, AppTheme.mediumColor, allProgress),
                    const SizedBox(height: 8),
                    _buildDifficultyRow(l10n.hard, 501, 750, AppTheme.hardColor, allProgress),
                    const SizedBox(height: 8),
                    _buildDifficultyRow(l10n.expert, 751, 1200, AppTheme.expertColor, allProgress),

                    const SizedBox(height: 24),

                    // Daily Challenge Calendar
                    Text(
                      l10n.dailyChallenge,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDailyCalendar(),
                  ],
                ),
              ),
            ],
          ),
        ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard(BuildContext context, int completed, int total) {
    final l10n = AppLocalizations.of(context)!;
    final progress = total > 0 ? completed / total : 0.0;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.glassDecoration(borderRadius: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.overallProgress,
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
            l10n.levelsOf(completed, total),
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

  Widget _buildDailyCalendar() {
    final completedDates = DailyChallengeService.instance.completedDates.toSet();
    final now = DateTime.now();
    final firstDay = DateTime(now.year, now.month, 1);
    final lastDay = DateTime(now.year, now.month + 1, 0);
    final startWeekday = firstDay.weekday % 7; // 0=Sun

    final months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    final days = ['S','M','T','W','T','F','S'];

    final completedThisMonth = completedDates.where((d) {
      return d.startsWith('${now.year}-${now.month.toString().padLeft(2, '0')}');
    }).length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.glassDecoration(borderRadius: 16),
      child: Column(
        children: [
          // Month header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${months[now.month - 1]} ${now.year}',
                style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
              ),
              Text(
                '$completedThisMonth / ${lastDay.day}',
                style: TextStyle(
                  fontSize: 13, color: AppTheme.textSecondary.withValues(alpha: 0.7)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Day-of-week headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: days.map((d) => SizedBox(
              width: 32,
              child: Center(child: Text(d,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textMuted.withValues(alpha: 0.5),
                  ))),
            )).toList(),
          ),
          const SizedBox(height: 8),

          // Calendar grid
          ...List.generate(6, (week) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(7, (dow) {
                  final dayIndex = week * 7 + dow - startWeekday + 1;
                  if (dayIndex < 1 || dayIndex > lastDay.day) {
                    return const SizedBox(width: 32, height: 32);
                  }

                  final dateStr = '${now.year}-${now.month.toString().padLeft(2, '0')}-${dayIndex.toString().padLeft(2, '0')}';
                  final isCompleted = completedDates.contains(dateStr);
                  final isToday = dayIndex == now.day;
                  final isPast = dayIndex < now.day;

                  return SizedBox(
                    width: 32,
                    height: 32,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isCompleted
                            ? AppTheme.successColor.withValues(alpha: 0.2)
                            : isToday
                                ? AppTheme.primaryColor.withValues(alpha: 0.1)
                                : null,
                        border: isToday
                            ? Border.all(color: AppTheme.primaryColor, width: 2)
                            : null,
                      ),
                      child: Center(
                        child: isCompleted
                            ? Icon(Icons.check_rounded,
                                size: 16, color: AppTheme.successColor)
                            : Text(
                                '$dayIndex',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
                                  color: isToday
                                      ? AppTheme.primaryColor
                                      : isPast
                                          ? AppTheme.textMuted.withValues(alpha: 0.3)
                                          : Colors.white.withValues(alpha: 0.5),
                                ),
                              ),
                      ),
                    ),
                  );
                }),
              ),
            );
          }),
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
