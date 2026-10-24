import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Shows an error message near the top of the screen, where it doesn't cover
/// the number pad and action buttons.
void showTopError(BuildContext context, String message) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.clearSnackBars();
  messenger.showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline_rounded, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      backgroundColor: AppTheme.errorColor.withValues(alpha: 0.95),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 140,
        left: 40,
        right: 40,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      duration: const Duration(seconds: 2),
    ),
  );
}
