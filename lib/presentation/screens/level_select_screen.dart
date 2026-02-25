import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/puzzle.dart';
import '../../levels/puzzle_generator.dart';
import '../../data/datasources/local_database.dart';

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
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.85,
      ),
      itemCount: adjustedEnd - startLevel + 1,
      itemBuilder: (context, index) {
        final levelNum = startLevel + index;
        final progress = LocalDatabase.instance.getProgress(levelNum);
        final isCompleted = progress?.isCompleted ?? false;
        final stars = progress?.stars ?? 0;

        final diffColor = switch (difficulty) {
          DifficultyLevel.easy => AppTheme.easyColor,
          DifficultyLevel.medium => AppTheme.mediumColor,
          DifficultyLevel.hard => AppTheme.hardColor,
          DifficultyLevel.expert => AppTheme.expertColor,
        };

        return GestureDetector(
          onTap: () => context.push('/game/$levelNum'),
          child: Container(
            decoration: BoxDecoration(
              color: isCompleted
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$levelNum',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isCompleted ? diffColor : Colors.white,
                  ),
                ),
                if (isCompleted) ...[
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (i) {
                      return Icon(
                        i < stars ? Icons.star_rounded : Icons.star_border_rounded,
                        size: 12,
                        color: i < stars
                            ? AppTheme.primaryColor
                            : AppTheme.textMuted.withValues(alpha: 0.4),
                      );
                    }),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
