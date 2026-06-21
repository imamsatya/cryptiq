import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/puzzle.dart';
import '../../levels/puzzle_generator.dart';
import '../../data/datasources/local_database.dart';
import '../../domain/entities/user_progress.dart';
import '../../core/constants/app_constants.dart';

class LevelSelectScreen extends ConsumerWidget {
  const LevelSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
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
                      Text(
                        l10n.selectLevel,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Difficulty tabs
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: AppTheme.glassDecoration(borderRadius: 14),
                  child: TabBar(
                    labelColor: AppTheme.backgroundDark,
                    unselectedLabelColor: AppTheme.textSecondary,
                    labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    unselectedLabelStyle: const TextStyle(fontSize: 13),
                    indicator: BoxDecoration(
                      gradient: AppTheme.goldGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    padding: const EdgeInsets.all(4),
                    tabs: [
                      Tab(text: l10n.easy),
                      Tab(text: l10n.medium),
                      Tab(text: l10n.hard),
                      Tab(text: l10n.expert),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Level grids
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildLevelGrid(context, DifficultyLevel.easy, 1, 250),
                      _buildLevelGrid(context, DifficultyLevel.medium, 251, 500),
                      _buildLevelGrid(context, DifficultyLevel.hard, 501, 750),
                      _buildLevelGrid(context, DifficultyLevel.expert, 751, 1200),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLevelGrid(
    BuildContext context,
    DifficultyLevel difficulty,
    int startLevel,
    int endLevel,
  ) {
    final totalLevels = PuzzleGenerator.totalPuzzles;
    final adjustedEnd = endLevel > totalLevels ? totalLevels : endLevel;

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.72,
      ),
      itemCount: adjustedEnd - startLevel + 1,
      itemBuilder: (context, index) {
        final levelNum = startLevel + index;
        final progress = LocalDatabase.instance.getProgress(levelNum);
        final highestCompleted = LocalDatabase.instance.getHighestCompletedLevel();
        final isCompleted = progress?.isCompleted ?? false;
        final stars = progress?.stars ?? 0;
        final isLocked = levelNum > highestCompleted + 1 && !AppConstants.devProMode;
        final isNew = !isCompleted && !isLocked && progress == null && levelNum <= endLevel;

        final diffColor = switch (difficulty) {
          DifficultyLevel.easy => AppTheme.easyColor,
          DifficultyLevel.medium => AppTheme.mediumColor,
          DifficultyLevel.hard => AppTheme.hardColor,
          DifficultyLevel.expert => AppTheme.expertColor,
        };

        return GestureDetector(
          onTap: () {
            if (isLocked) {
              HapticFeedback.lightImpact();
              return;
            }
            if (!isCompleted) {
              context.push('/game/$levelNum');
              return;
            }
            // Completed — show View Solution / Replay dialog
            _showLevelActionSheet(context, levelNum, progress!.stars);
          },
          onLongPress: isCompleted
              ? () => _showLevelDetailSheet(context, levelNum, progress!)
              : null,
          child: Container(
            decoration: BoxDecoration(
              color: isLocked
                  ? AppTheme.surfaceColor.withValues(alpha: 0.2)
                  : isCompleted
                      ? diffColor.withValues(alpha: 0.15)
                  : AppTheme.surfaceColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isCompleted
                    ? diffColor.withValues(alpha: 0.4)
                    : Colors.white.withValues(alpha: 0.08),
                width: 1.5,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isLocked)
                          Icon(
                            Icons.lock_rounded,
                            color: Colors.white.withValues(alpha: 0.2),
                            size: 20,
                          )
                        else
                          Text(
                            '$levelNum',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: isCompleted
                                  ? diffColor
                                  : Colors.white,
                            ),
                          ),
                        if (isCompleted) ...[
                          const SizedBox(height: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (i) {
                              return Icon(
                                i < stars ? Icons.star_rounded : Icons.star_border_rounded,
                                size: 10,
                                color: i < stars
                                    ? AppTheme.primaryColor
                                    : AppTheme.textMuted.withValues(alpha: 0.3),
                              );
                            }),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _formatTime(progress!.bestTimeSeconds),
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                          Text(
                            '${progress.attempts}x',
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.white.withValues(alpha: 0.35),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                // Completed checkmark
                if (isCompleted)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Icon(
                      Icons.check_circle_rounded,
                      size: 10,
                      color: diffColor.withValues(alpha: 0.6),
                    ),
                  ),
                // NEW badge for unplayed levels
                if (isNew)
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.newBadge,
                        style: TextStyle(
                          fontSize: 7,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.backgroundDark,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  void _showLevelDetailSheet(BuildContext context, int levelNum, UserProgress progress) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 12),

              // CryptiQ + Difficulty
              ShaderMask(
                shaderCallback: (bounds) => AppTheme.goldGradient.createShader(bounds),
                child: const Text('CryptiQ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 2)),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: AppTheme.glassDecoration(borderRadius: 8),
                child: Text(
                  levelNum <= 250 ? l10n.easy : levelNum <= 500 ? l10n.medium : levelNum <= 750 ? l10n.hard : l10n.expert,
                  style: TextStyle(fontSize: 10, color: AppTheme.textSecondary),
                ),
              ),
              const SizedBox(height: 8),

              // Level title
              Text(
                l10n.level(levelNum),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              const SizedBox(height: 14),

              // All stats in one row
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                decoration: AppTheme.glassDecoration(borderRadius: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDetailStat(Icons.timer_outlined, _formatTime(progress.bestTimeSeconds), l10n.bestTime),
                    Container(width: 1, height: 36, color: Colors.white.withValues(alpha: 0.1)),
                    _buildDetailStat(Icons.replay_rounded, '${progress.attempts}x', l10n.attempts),
                    Container(width: 1, height: 36, color: Colors.white.withValues(alpha: 0.1)),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(3, (i) => Icon(
                            i < progress.stars ? Icons.star_rounded : Icons.star_border_rounded,
                            size: 16,
                            color: i < progress.stars ? AppTheme.primaryColor : AppTheme.textMuted.withValues(alpha: 0.4),
                          )),
                        ),
                        const SizedBox(height: 2),
                        Text(l10n.stars(progress.stars),
                            style: TextStyle(fontSize: 9, color: AppTheme.textSecondary)),
                      ],
                    ),
                    Container(width: 1, height: 36, color: Colors.white.withValues(alpha: 0.1)),
                    _buildDetailStat(Icons.lightbulb_outline_rounded, '${progress.totalHintsUsed}', l10n.hintsUsed),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Share + Close buttons
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(ctx);
                        SharePlus.instance.share(
                          ShareParams(
                            text: 'CryptiQ ${l10n.level(levelNum)} ⭐${progress.stars}/3\n'
                                '⏱ ${_formatTime(progress.bestTimeSeconds)} | '
                                '🔄 ${progress.attempts}x\n'
                                '${l10n.beatMyTime}',
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: AppTheme.goldGlowDecoration(borderRadius: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.share_rounded, color: AppTheme.backgroundDark, size: 18),
                            const SizedBox(width: 6),
                            Text(l10n.share,
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.backgroundDark)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(ctx),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: AppTheme.glassDecoration(borderRadius: 14),
                        child: Center(
                          child: Text(l10n.close,
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textSecondary)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailStat(IconData icon, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppTheme.primaryColor, size: 24),
        const SizedBox(height: 6),
        Text(value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
        const SizedBox(height: 2),
        Text(label,
            style: TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
      ],
    );
  }

  void _showLevelActionSheet(BuildContext context, int levelNum, int stars) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),

            // Level title with stars
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.level(levelNum),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                ...List.generate(3, (i) => Icon(
                  i < stars ? Icons.star_rounded : Icons.star_border_rounded,
                  size: 20,
                  color: i < stars
                      ? AppTheme.primaryColor
                      : AppTheme.textMuted.withValues(alpha: 0.4),
                )),
              ],
            ),
            const SizedBox(height: 24),

            // View Solution button
            GestureDetector(
              onTap: () {
                Navigator.pop(ctx);
                context.push('/game/$levelNum?viewOnly=true');
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: AppTheme.glassDecoration(borderRadius: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.visibility_rounded,
                        color: AppTheme.primaryColor, size: 22),
                    const SizedBox(width: 10),
                    Text(
                      l10n.viewSolution,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Replay button
            GestureDetector(
              onTap: () {
                Navigator.pop(ctx);
                if (stars >= 3) {
                  // Confirm replay for ⭐⭐⭐ levels
                  showDialog(
                    context: context,
                    builder: (ctx2) => AlertDialog(
                      backgroundColor: AppTheme.surfaceColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      title: Text(l10n.replayConfirmTitle,
                          style: const TextStyle(color: Colors.white, fontSize: 16)),
                      content: Text(l10n.replayConfirmBody,
                          style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx2),
                          child: Text(l10n.cancel, style: TextStyle(color: AppTheme.textMuted)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(ctx2);
                            context.push('/game/$levelNum');
                          },
                          child: Text(l10n.replay, style: TextStyle(color: AppTheme.primaryColor)),
                        ),
                      ],
                    ),
                  );
                } else {
                  context.push('/game/$levelNum');
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: AppTheme.glassDecoration(borderRadius: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.replay_rounded,
                        color: Colors.white, size: 22),
                    const SizedBox(width: 10),
                    Text(
                      l10n.replay,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
