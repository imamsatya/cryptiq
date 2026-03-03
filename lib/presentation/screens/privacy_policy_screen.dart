import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';

/// Privacy Policy screen — required by Play Store.
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                    Text(
                      l10n.privacyPolicy,
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
                        _section(l10n.lastUpdated, 'March 2026'),
                        _section(
                          l10n.overview,
                          l10n.privacyOverviewBody,
                        ),
                        _section(
                          l10n.dataCollection,
                          l10n.privacyDataBody,
                        ),
                        _section(
                          l10n.thirdPartyServices,
                          '• Google AdMob — displays ads. AdMob may collect device identifiers and usage data per Google\'s privacy policy.\n'
                          '• Google Play / App Store — handles in-app purchases. Transaction data is managed by respective stores.',
                        ),
                        _section(
                          l10n.dataStorage,
                          l10n.privacyStorageBody,
                        ),
                        _section(
                          l10n.childrenPrivacy,
                          '${AppConstants.appName} does not knowingly collect information from children under 13.',
                        ),
                        _section(
                          l10n.changes,
                          l10n.privacyChangesBody,
                        ),
                        _section(
                          l10n.contact,
                          l10n.privacyContactBody(AppConstants.contactEmail),
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
