import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/theme_presets.dart';
import '../../core/services/audio_service.dart';
import '../../core/services/iap_service.dart';
import '../../core/services/notification_service.dart';
import '../../data/datasources/local_database.dart';
import '../../core/constants/app_constants.dart';
import '../providers/theme_provider.dart';
import '../providers/locale_provider.dart';
import 'onboarding_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late bool _soundEnabled;
  late bool _hapticsEnabled;
  late bool _notificationsEnabled;

  @override
  void initState() {
    super.initState();
    _soundEnabled = LocalDatabase.instance.getSoundEnabled();
    _hapticsEnabled = LocalDatabase.instance.getHapticsEnabled();
    _notificationsEnabled = NotificationService.instance.isEnabled;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isPro = LocalDatabase.instance.getProStatus();
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
                    Text(
                      l10n.settings,
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
                    // Go Pro Section
                    _buildProCard(isPro),
                    const SizedBox(height: 20),

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
                    _buildToggleTile(
                      icon: Icons.notifications_outlined,
                      title: 'Daily Reminder',
                      value: _notificationsEnabled,
                      onChanged: (val) async {
                        setState(() => _notificationsEnabled = val);
                        await NotificationService.instance.setEnabled(val);
                      },
                    ),
                    const SizedBox(height: 8),
                    _buildTapTile(
                      icon: Icons.school_rounded,
                      title: l10n.replayTutorial,
                      onTap: () async {
                        await OnboardingScreen.reset();
                        if (context.mounted) {
                          context.go('/onboarding');
                        }
                      },
                    ),

                    const SizedBox(height: 24),

                    // Themes
                    _buildSectionTitle(l10n.theme),
                    const SizedBox(height: 8),
                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.85,
                      children: ThemePresets.all.map((preset) {
                        final isActive = ThemeService.instance.selectedThemeId == preset.id;
                        return GestureDetector(
                          onTap: () async {
                            await ref.read(themeProvider.notifier).setTheme(preset.id);
                            if (mounted) setState(() {});
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: preset.surfaceColor.withValues(alpha: 0.6),
                              border: Border.all(
                                color: isActive
                                    ? preset.primaryColor
                                    : Colors.white.withValues(alpha: 0.1),
                                width: isActive ? 2 : 1,
                              ),
                              boxShadow: isActive
                                  ? [
                                      BoxShadow(
                                        color: preset.primaryColor
                                            .withValues(alpha: 0.3),
                                        blurRadius: 12,
                                        spreadRadius: -2,
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Color swatch row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    _colorDot(preset.primaryColor),
                                    const SizedBox(width: 4),
                                    _colorDot(preset.backgroundDark),
                                    const SizedBox(width: 4),
                                    _colorDot(preset.surfaceColor),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  preset.emoji,
                                  style: const TextStyle(fontSize: 22),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  preset.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: isActive
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: isActive
                                        ? preset.primaryColor
                                        : AppTheme.textSecondary,
                                  ),
                                ),
                                if (isActive)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Icon(Icons.check_circle_rounded,
                                        color: preset.primaryColor, size: 16),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // Language
                    _buildSectionTitle(l10n.language),
                    const SizedBox(height: 8),
                    Container(
                      decoration: AppTheme.glassDecoration(borderRadius: 14),
                      child: Column(
                        children: supportedLanguages.map((lang) {
                          final isActive = ref.read(localeProvider.notifier).selectedCode == lang.code;
                          return InkWell(
                            onTap: () async {
                              await ref.read(localeProvider.notifier).setLocale(lang.code);
                              if (mounted) setState(() {});
                            },
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: isActive
                                  ? BoxDecoration(
                                      color: AppTheme.primaryColor.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(14),
                                    )
                                  : null,
                              child: Row(
                                children: [
                                  Text(lang.flag, style: const TextStyle(fontSize: 22)),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Text(
                                      lang.name,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                                        color: isActive ? AppTheme.primaryColor : Colors.white,
                                      ),
                                    ),
                                  ),
                                  if (isActive)
                                    Icon(Icons.check_rounded,
                                        color: AppTheme.primaryColor, size: 20),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // About
                    _buildSectionTitle(l10n.about),
                    const SizedBox(height: 8),
                    _buildInfoTile(
                      icon: Icons.info_outline_rounded,
                      title: l10n.version,
                      subtitle: AppConstants.appVersion,
                    ),
                    const SizedBox(height: 8),
                    _buildTapTile(
                      icon: Icons.privacy_tip_outlined,
                      title: l10n.privacyPolicy,
                      onTap: () {
                        // TODO: Open privacy policy URL
                      },
                    ),
                    const SizedBox(height: 8),
                    _buildTapTile(
                      icon: Icons.email_outlined,
                      title: l10n.contactUs,
                      onTap: () {
                        // TODO: Open email
                      },
                    ),

                    const SizedBox(height: 32),

                    // Free notice
                    Container(
                      padding: EdgeInsets.all(16),
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
                                Text(
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

  Widget _buildProCard(bool isPro) {
    return Container(
      decoration: BoxDecoration(
        gradient: isPro
            ? LinearGradient(colors: [Colors.green.shade800, Colors.green.shade600])
            : const LinearGradient(colors: [Color(0xFFD4A843), Color(0xFFB8860B)]),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: (isPro ? Colors.green : const Color(0xFFD4A843)).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(isPro ? Icons.verified_rounded : Icons.workspace_premium_rounded,
                    color: Colors.white, size: 28),
                const SizedBox(width: 12),
                Text(
                  isPro ? 'CryptiQ Pro ✓' : 'Go Pro',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                if (!isPro)
                  Text(
                    IapService.instance.proPriceString,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            _proBenefit(Icons.block_rounded, 'No Ads'),
            _proBenefit(Icons.palette_rounded, 'All Themes'),
            _proBenefit(Icons.lightbulb_rounded, '+1 Bonus Hint'),
            if (!isPro) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await IapService.instance.purchasePro();
                    if (mounted) setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFB8860B),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Upgrade to Pro',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    await IapService.instance.restorePurchases();
                    await Future.delayed(const Duration(seconds: 1));
                    if (mounted) setState(() {});
                  },
                  child: Text(
                    'Restore Purchase',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.7),
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _proBenefit(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(icon, color: Colors.white.withValues(alpha: 0.9), size: 16),
          const SizedBox(width: 10),
          Text(text,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 14)),
        ],
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
                style: TextStyle(
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

  Widget _colorDot(Color color) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
    );
  }
}
