import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Friendly error screen shown instead of the red screen of death.
class ErrorScreen extends StatelessWidget {
  final FlutterErrorDetails? details;
  final String? message;

  const ErrorScreen({super.key, this.details, this.message});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Error icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.withValues(alpha: 0.1),
                      border: Border.all(
                          color: Colors.red.withValues(alpha: 0.3), width: 2),
                    ),
                    child: const Icon(
                      Icons.error_outline_rounded,
                      size: 40,
                      color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Title
                  const Text(
                    'Oops! Something went wrong',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),

                  // Message
                  Text(
                    message ??
                        'An unexpected error occurred.\nPlease try restarting the app.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary.withValues(alpha: 0.7),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // Retry button (only works if Navigator is available)
                  GestureDetector(
                    onTap: () {
                      // Try to navigate home
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 14),
                      decoration:
                          AppTheme.goldGlowDecoration(borderRadius: 14),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.home_rounded,
                              color: AppTheme.backgroundDark, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Go Home',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.backgroundDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
