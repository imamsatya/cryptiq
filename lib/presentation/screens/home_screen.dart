import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../levels/puzzle_generator.dart';
import '../providers/progress_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedLevels = ref.watch(completedLevelsProvider);
    final totalStars = ref.watch(totalStarsProvider);
    final lastPlayed = ref.watch(lastPlayedLevelProvider);
    final totalLevels = PuzzleGenerator.totalPuzzles;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Settings button
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () => context.push('/settings'),
                    icon: Icon(Icons.settings_rounded,
                        color: AppTheme.textSecondary.withValues(alpha: 0.7)),
                  ),
                ),

                const Spacer(flex: 2),

                // Logo & title
                _buildLogo(),
                const SizedBox(height: 8),
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppTheme.goldGradient.createShader(bounds),
                  child: const Text(
                    'CryptiQ',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 4,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Decode the Logic',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary.withValues(alpha: 0.7),
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 32),

                // Stats row
                _buildStatsRow(completedLevels, totalLevels, totalStars),

                const SizedBox(height: 40),

                // Play button
                _buildPlayButton(context, lastPlayed),
                const SizedBox(height: 16),

                // Level select button
                _buildMenuButton(
                  context,
                  icon: Icons.grid_view_rounded,
                  label: 'Select Level',
                  onTap: () => context.push('/levels'),
                ),
                const SizedBox(height: 12),

                // Stats & Settings row
                Row(
                  children: [
                    Expanded(
                      child: _buildMenuButton(
                        context,
                        icon: Icons.bar_chart_rounded,
                        label: 'Statistics',
                        onTap: () => context.push('/statistics'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildMenuButton(
                        context,
                        icon: Icons.settings_rounded,
                        label: 'Settings',
                        onTap: () => context.push('/settings'),
                      ),
                    ),
                  ],
                ),

                const Spacer(flex: 3),

                // Footer
                Text(
                  'All 500 levels FREE — no locked levels, ever.',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.textMuted.withValues(alpha: 0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppTheme.goldGradient,
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.3),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'C',
          style: TextStyle(
            fontSize: 52,
            fontWeight: FontWeight.w700,
            color: AppTheme.backgroundDark,
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow(int completed, int total, int stars) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: AppTheme.glassDecoration(borderRadius: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem(Icons.check_circle_outline, '$completed/$total', 'Levels'),
          Container(width: 1, height: 30, color: Colors.white.withValues(alpha: 0.1)),
          _buildStatItem(Icons.star_rounded, '$stars', 'Stars'),
          Container(width: 1, height: 30, color: Colors.white.withValues(alpha: 0.1)),
          _buildStatItem(Icons.emoji_events_rounded, '${(completed / total * 100).toStringAsFixed(0)}%', 'Progress'),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppTheme.primaryColor, size: 20),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
        Text(label,
            style: TextStyle(
                fontSize: 10, color: AppTheme.textSecondary.withValues(alpha: 0.7))),
      ],
    );
  }

  Widget _buildPlayButton(BuildContext context, int lastPlayed) {
    final nextLevel = lastPlayed > 0 ? lastPlayed + 1 : 1;
    final isResume = lastPlayed > 0;

    return GestureDetector(
      onTap: () {
        final level = nextLevel > PuzzleGenerator.totalPuzzles ? 1 : nextLevel;
        context.push('/game/$level');
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: AppTheme.goldGlowDecoration(borderRadius: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isResume ? Icons.play_arrow_rounded : Icons.play_arrow_rounded,
              color: AppTheme.backgroundDark,
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              isResume ? 'Continue (Level $nextLevel)' : 'Play',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppTheme.backgroundDark,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: AppTheme.glassDecoration(borderRadius: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppTheme.primaryColor, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
