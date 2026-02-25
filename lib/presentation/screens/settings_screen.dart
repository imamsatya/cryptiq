import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/audio_service.dart';
import '../../data/datasources/local_database.dart';
import '../../core/constants/app_constants.dart';
import 'onboarding_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _soundEnabled;
  late bool _hapticsEnabled;

  @override
  void initState() {
    super.initState();
    _soundEnabled = LocalDatabase.instance.getSoundEnabled();
    _hapticsEnabled = LocalDatabase.instance.getHapticsEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      'Settings',
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
                    // Game Settings
                    _buildSectionTitle('Game'),
                    const SizedBox(height: 8),
                    _buildToggleTile(
                      icon: Icons.volume_up_rounded,
                      title: 'Sound Effects',
                      value: _soundEnabled,
                      onChanged: (val) async {
                        setState(() => _soundEnabled = val);
                        await AudioService.instance.toggleSound(val);
                      },
                    ),
                    const SizedBox(height: 8),
                    _buildToggleTile(
                      icon: Icons.vibration_rounded,
                      title: 'Haptic Feedback',
                      value: _hapticsEnabled,
                      onChanged: (val) async {
                        setState(() => _hapticsEnabled = val);
                        await LocalDatabase.instance.setHapticsEnabled(val);
                      },
                    ),
                    const SizedBox(height: 8),
                    _buildTapTile(
                      icon: Icons.school_rounded,
                      title: 'Replay Tutorial',
                      onTap: () async {
                        await OnboardingScreen.reset();
                        if (context.mounted) {
                          context.go('/onboarding');
                        }
                      },
                    ),

                    const SizedBox(height: 24),

                    // About
                    _buildSectionTitle('About'),
                    const SizedBox(height: 8),
                    _buildInfoTile(
                      icon: Icons.info_outline_rounded,
                      title: 'Version',
                      subtitle: AppConstants.appVersion,
                    ),
                    const SizedBox(height: 8),
                    _buildTapTile(
                      icon: Icons.privacy_tip_outlined,
                      title: 'Privacy Policy',
                      onTap: () {
                        // TODO: Open privacy policy URL
                      },
                    ),
                    const SizedBox(height: 8),
                    _buildTapTile(
                      icon: Icons.email_outlined,
                      title: 'Contact Us',
                      onTap: () {
                        // TODO: Open email
                      },
                    ),

                    const SizedBox(height: 32),

                    // Free notice
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.primaryColor.withValues(alpha: 0.1),
                            AppTheme.secondaryColor.withValues(alpha: 0.05),
                          ],
                        ),
                        border: Border.all(
                          color: AppTheme.primaryColor.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.lock_open_rounded,
                              color: AppTheme.primaryColor, size: 28),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'All 1200 Levels FREE',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                                Text(
                                  'No locked levels, no paywall. Enjoy!',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.textSecondary.withValues(alpha: 0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppTheme.primaryColor.withValues(alpha: 0.8),
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildToggleTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: AppTheme.glassDecoration(borderRadius: 14),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.textSecondary, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppTheme.primaryColor,
            activeThumbColor: Colors.white,
            inactiveTrackColor: AppTheme.surfaceColor,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: AppTheme.glassDecoration(borderRadius: 14),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.textSecondary, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
          ),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 14, color: AppTheme.textSecondary.withValues(alpha: 0.7))),
        ],
      ),
    );
  }

  Widget _buildTapTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: AppTheme.glassDecoration(borderRadius: 14),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.textSecondary, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
            ),
            Icon(Icons.chevron_right_rounded,
                color: AppTheme.textMuted.withValues(alpha: 0.5), size: 22),
          ],
        ),
      ),
    );
  }
}
