import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/daily_challenge_service.dart';
import '../../core/services/achievement_service.dart';
import '../../core/services/iap_service.dart';
import '../../data/datasources/local_database.dart';
import '../../levels/puzzle_generator.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final highestCompleted = LocalDatabase.instance.getHighestCompletedLevel();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 12),

                const Spacer(flex: 2),

                // Logo & title
                _buildLogo(),
                SizedBox(height: 8),
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
                  l10n.decodeTheLogic,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary.withValues(alpha: 0.7),
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 16),

                // Daily Challenge card
                _buildDailyCard(context),

                const SizedBox(height: 16),

                // Play button
                _buildPlayButton(context, highestCompleted),
                const SizedBox(height: 10),

                // Completion progress
                Center(
                  child: Text(
                    l10n.levelsCompleted(highestCompleted, PuzzleGenerator.totalPuzzles),
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary.withValues(alpha: 0.6),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Level select button
                _buildMenuButton(
                  context,
                  icon: Icons.grid_view_rounded,
                  label: l10n.settings.contains('') ? 'Select Level' : 'Select Level',
                  onTap: () => context.push('/levels'),
                ),
                const SizedBox(height: 8),

                // Pass & Play button
                _buildMenuButton(
                  context,
                  icon: Icons.people_rounded,
                  label: l10n.passAndPlay,
                  onTap: () => context.push('/multiplayer'),
                ),
                const SizedBox(height: 8),

                // Stats, Achievements & Settings — icon only
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIconButton(
                      icon: Icons.bar_chart_rounded,
                      tooltip: l10n.statistics,
                      onTap: () => context.push('/statistics'),
                    ),
                    const SizedBox(width: 16),
                    _buildIconButton(
                      icon: Icons.emoji_events_rounded,
                      tooltip: l10n.badges,
                      badge: AchievementService.instance.unlockedCount,
                      onTap: () => context.push('/achievements'),
                    ),
                    const SizedBox(width: 16),
                    _buildIconButton(
                      icon: Icons.settings_rounded,
                      tooltip: l10n.settings,
                      onTap: () => context.push('/settings'),
                    ),
                  ],
                ),

                const Spacer(flex: 2),

                // Go Pro banner (only for non-pro users)
                if (!LocalDatabase.instance.getProStatus())
                  GestureDetector(
                    onTap: () async {
                      await IapService.instance.purchasePro();
                      if (mounted) setState(() {});
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFD4A843), Color(0xFFB8860B)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFD4A843).withValues(alpha: 0.25),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.workspace_premium_rounded,
                                  color: Colors.white, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                l10n.upgradeToPro,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text('👑', style: TextStyle(fontSize: 14)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${l10n.noAds} • ${l10n.bonusHint} • ${l10n.allThemes}',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const Spacer(),

                // Footer
                Text(
                  '${l10n.allLevelsFree} — ${l10n.noLockedLevels}',
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
      child: Center(
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



  Widget _buildDailyCard(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final daily = DailyChallengeService.instance;
    final isCompleted = daily.isTodayCompleted;
    final streak = daily.streak;
    final now = DateTime.now();
    final months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    final dateStr = '${now.day} ${months[now.month - 1]} ${now.year}';

    return GestureDetector(
      onTap: () => context.push('/daily'),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: isCompleted
              ? LinearGradient(
                  colors: [
                    AppTheme.successColor.withValues(alpha: 0.15),
                    AppTheme.successColor.withValues(alpha: 0.05),
                  ],
                )
              : LinearGradient(
                  colors: [
                    AppTheme.primaryColor.withValues(alpha: 0.15),
                    AppTheme.primaryColor.withValues(alpha: 0.05),
                  ],
                ),
          border: Border.all(
            color: isCompleted
                ? AppTheme.successColor.withValues(alpha: 0.3)
                : AppTheme.primaryColor.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              isCompleted ? Icons.check_circle_rounded : Icons.today_rounded,
              color: isCompleted ? AppTheme.successColor : AppTheme.primaryColor,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.dailyChallenge,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isCompleted ? AppTheme.successColor : Colors.white,
                    ),
                  ),
                  Text(
                    dateStr,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppTheme.textSecondary.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            if (streak > 0) ...[
              Text('🔥 $streak',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              SizedBox(width: 12),
            ],
            Icon(
              isCompleted ? Icons.replay_rounded : Icons.play_arrow_rounded,
              color: isCompleted ? AppTheme.successColor : AppTheme.primaryColor,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayButton(BuildContext context, int lastPlayed) {
    final l10n = AppLocalizations.of(context)!;
    final nextLevel = lastPlayed > 0 ? lastPlayed + 1 : 1;
    final isResume = lastPlayed > 0;

    return GestureDetector(
      onTap: () {
        final level = nextLevel > PuzzleGenerator.totalPuzzles ? 1 : nextLevel;
        context.push('/game/$level');
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 18),
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
              isResume ? l10n.continueLevel(nextLevel) : l10n.play,
              style: TextStyle(
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
    int? badge,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: AppTheme.glassDecoration(borderRadius: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppTheme.primaryColor, size: 18),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                badge != null ? '$label ($badge)' : label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
    int? badge,
  }) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: AppTheme.glassDecoration(borderRadius: 16),
              child: Icon(icon, color: AppTheme.primaryColor, size: 24),
            ),
            if (badge != null && badge > 0)
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primaryColor,
                  ),
                  child: Text(
                    '$badge',
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
