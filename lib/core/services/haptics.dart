import 'package:flutter/services.dart';
import '../../data/datasources/local_database.dart';

/// [HapticFeedback] that respects the Haptic Feedback toggle in Settings.
class Haptics {
  Haptics._();

  static bool get _enabled => LocalDatabase.instance.getHapticsEnabled();

  static Future<void> lightImpact() async {
    if (_enabled) await HapticFeedback.lightImpact();
  }

  static Future<void> mediumImpact() async {
    if (_enabled) await HapticFeedback.mediumImpact();
  }

  static Future<void> heavyImpact() async {
    if (_enabled) await HapticFeedback.heavyImpact();
  }

  static Future<void> selectionClick() async {
    if (_enabled) await HapticFeedback.selectionClick();
  }
}
