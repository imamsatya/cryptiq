import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:in_app_update/in_app_update.dart';

/// Service to check for app updates via Google Play Core.
class UpdateChecker {
  UpdateChecker._();
  static final instance = UpdateChecker._();

  bool _checkedThisSession = false;

  /// Check if an update is available on Google Play and force it.
  /// Once per app session: the home screen is rebuilt after every level, and
  /// a user who dismissed the update shouldn't be shown it again each time.
  Future<void> checkForUpdates() async {
    // In-App Updates are only supported on Android.
    if (kIsWeb || !Platform.isAndroid) return;
    if (_checkedThisSession) return;
    _checkedThisSession = true;

    try {
      final updateInfo = await InAppUpdate.checkForUpdate();
      
      // If an update is available, we force an immediate update.
      // This will pop up the green Google Play overlay and block the user
      // until they update.
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        await InAppUpdate.performImmediateUpdate();
      }
    } catch (e) {
      debugPrint('Failed to check for in-app updates: $e');
    }
  }
}
