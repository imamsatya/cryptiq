import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';

/// Privacy Policy screen — required by Play Store.
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      onTap: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/');
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: AppTheme.glassDecoration(borderRadius: 12),
                        child: const Icon(Icons.arrow_back_rounded,
                            color: Colors.white, size: 22),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: AppTheme.glassDecoration(borderRadius: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _section('Last Updated', 'March 2026'),
                        _section(
                          'Overview',
                          '${AppConstants.appName} is a cryptarithm puzzle game. '
                          'We respect your privacy and are committed to protecting your personal information.',
                        ),
                        _section(
                          'Data Collection',
                          '${AppConstants.appName} does NOT collect, store, or transmit any personal data. '
                          'All game progress is stored locally on your device using offline storage (Hive). '
                          'We do not require account creation or login.',
                        ),
                        _section(
                          'Third-Party Services',
                          '• Google AdMob — displays ads. AdMob may collect device identifiers and usage data per Google\'s privacy policy.\n'
                          '• Google Play / App Store — handles in-app purchases. Transaction data is managed by respective stores.',
                        ),
                        _section(
                          'Data Storage',
                          'All data (game progress, settings, achievements) is stored locally on your device. '
                          'Uninstalling the app will remove all local data.',
                        ),
                        _section(
                          'Children\'s Privacy',
                          '${AppConstants.appName} does not knowingly collect information from children under 13.',
                        ),
                        _section(
                          'Changes',
                          'We may update this policy. Continued use of the app after changes constitutes acceptance.',
                        ),
                        _section(
                          'Contact',
                          'For questions, email: ${AppConstants.contactEmail}',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section(String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
