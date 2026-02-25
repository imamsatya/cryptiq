import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/achievement_service.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = AchievementService.instance;
    final all = service.getAll();
    final unlocked = all.where((a) => a.$2).length;
    final total = all.length;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: AppTheme.glassDecoration(borderRadius: 12),
                        child: const Icon(Icons.arrow_back_rounded,
                            color: Colors.white, size: 22),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Achievements',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: AppTheme.glassDecoration(borderRadius: 12),
                      child: Text(
                        '$unlocked / $total',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Progress bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: total > 0 ? unlocked / total : 0,
                        backgroundColor: AppTheme.surfaceColor,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            AppTheme.primaryColor),
                        minHeight: 6,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${(unlocked / total * 100).toStringAsFixed(0)}% unlocked',
                      style: TextStyle(
                        fontSize: 11,
                        color:
                            AppTheme.textSecondary.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Achievement list
              Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  itemCount: all.length,
                  itemBuilder: (context, index) {
                    final (achievement, isUnlocked) = all[index];
                    return _buildAchievementTile(achievement, isUnlocked);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementTile(Achievement achievement, bool isUnlocked) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: isUnlocked
            ? AppTheme.primaryColor.withValues(alpha: 0.08)
            : AppTheme.surfaceColor.withValues(alpha: 0.4),
        border: Border.all(
          color: isUnlocked
              ? AppTheme.primaryColor.withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.06),
        ),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isUnlocked
                  ? AppTheme.primaryColor.withValues(alpha: 0.15)
                  : AppTheme.surfaceColor.withValues(alpha: 0.6),
            ),
            child: Center(
              child: Text(
                isUnlocked ? achievement.icon : '🔒',
                style: TextStyle(
                  fontSize: 22,
                  color: isUnlocked ? null : Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isUnlocked
                        ? Colors.white
                        : AppTheme.textMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  achievement.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: isUnlocked
                        ? AppTheme.textSecondary.withValues(alpha: 0.8)
                        : AppTheme.textMuted.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
          if (isUnlocked)
            const Icon(Icons.check_circle_rounded,
                color: AppTheme.primaryColor, size: 22),
        ],
      ),
    );
  }
}
