import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/theme_presets.dart';

/// Manages the current theme preset — changing this triggers a full rebuild
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemePreset>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemePreset> {
  ThemeNotifier() : super(ThemeService.instance.currentTheme);

  Future<void> setTheme(String themeId) async {
    await ThemeService.instance.setTheme(themeId);
    state = ThemePresets.getById(themeId);
  }
}
