import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../data/datasources/local_database.dart';

/// Service to check for app updates and show update dialog.
/// Uses a simple version comparison against a stored "latest" version.
/// In production, you'd check against Play Store or your own API.
class UpdateChecker {
  UpdateChecker._();
  static final instance = UpdateChecker._();

  static const _dismissedVersionKey = 'dismissed_update_version';

  /// Check if an update prompt should be shown.
  /// Returns true if the user hasn't dismissed the current prompt.
  Future<bool> shouldPrompt() async {
    final info = await PackageInfo.fromPlatform();
    final currentVersion = info.version;
    final dismissed = LocalDatabase.instance.settingsBox
        .get(_dismissedVersionKey, defaultValue: '');
    // Don't re-prompt if user already dismissed this version
    return dismissed != currentVersion;
  }

  /// Mark the current version as dismissed (user tapped "Later")
  Future<void> dismissUpdate() async {
    final info = await PackageInfo.fromPlatform();
    await LocalDatabase.instance.settingsBox
        .put(_dismissedVersionKey, info.version);
  }

  /// Show the update dialog
  static Future<void> showUpdateDialog(BuildContext context,
      {required String title,
      required String body,
      required String updateText,
      required String laterText}) async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E3A5F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title,
            style: const TextStyle(color: Colors.white, fontSize: 16)),
        content: Text(body,
            style:
                TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 13)),
        actions: [
          TextButton(
            onPressed: () {
              instance.dismissUpdate();
              Navigator.pop(ctx);
            },
            child: Text(laterText,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.5))),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              // In production: launch Play Store URL
              // launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=...'));
            },
            child: Text(updateText,
                style: const TextStyle(
                    color: Color(0xFFFFD700), fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
