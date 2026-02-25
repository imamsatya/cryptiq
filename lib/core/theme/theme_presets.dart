import 'package:flutter/material.dart';
import '../../data/datasources/local_database.dart';

/// A theme preset — defines all colors for a visual theme
class ThemePreset {
  final String id;
  final String name;
  final String emoji;
  // Primary accent
  final Color primaryColor;
  final Color secondaryColor;
  // Backgrounds
  final Color backgroundDark;
  final Color backgroundLight;
  final Color surfaceColor;
  final Color surfaceLight;

  const ThemePreset({
    required this.id,
    required this.name,
    required this.emoji,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundDark,
    required this.backgroundLight,
    required this.surfaceColor,
    required this.surfaceLight,
  });

  LinearGradient get backgroundGradient => LinearGradient(
        colors: [backgroundDark, backgroundLight],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

  LinearGradient get accentGradient => LinearGradient(
        colors: [primaryColor, secondaryColor],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  LinearGradient get goldGradient => LinearGradient(
        colors: [primaryColor, secondaryColor, secondaryColor.withValues(alpha: 0.8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  LinearGradient get surfaceGradient => LinearGradient(
        colors: [surfaceColor, surfaceLight],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}

/// All available theme presets
class ThemePresets {
  ThemePresets._();

  static const navyGold = ThemePreset(
    id: 'navy_gold',
    name: 'Navy Gold',
    emoji: '🌙',
    primaryColor: Color(0xFFFFD700),
    secondaryColor: Color(0xFFFFC107),
    backgroundDark: Color(0xFF0D1B2A),
    backgroundLight: Color(0xFF1B263B),
    surfaceColor: Color(0xFF1E3A5F),
    surfaceLight: Color(0xFF254670),
  );

  static const oceanTeal = ThemePreset(
    id: 'ocean_teal',
    name: 'Ocean Teal',
    emoji: '🌊',
    primaryColor: Color(0xFF4ECDC4),
    secondaryColor: Color(0xFF45B7AA),
    backgroundDark: Color(0xFF0A192F),
    backgroundLight: Color(0xFF112240),
    surfaceColor: Color(0xFF153350),
    surfaceLight: Color(0xFF1A3D5C),
  );

  static const midnightPurple = ThemePreset(
    id: 'midnight_purple',
    name: 'Midnight Purple',
    emoji: '💜',
    primaryColor: Color(0xFFBB86FC),
    secondaryColor: Color(0xFF9C6ADE),
    backgroundDark: Color(0xFF120B2E),
    backgroundLight: Color(0xFF1D1342),
    surfaceColor: Color(0xFF2A1B5E),
    surfaceLight: Color(0xFF352270),
  );

  static const forestGreen = ThemePreset(
    id: 'forest_green',
    name: 'Forest Green',
    emoji: '🌲',
    primaryColor: Color(0xFF66BB6A),
    secondaryColor: Color(0xFF4CAF50),
    backgroundDark: Color(0xFF0D1F12),
    backgroundLight: Color(0xFF162B1A),
    surfaceColor: Color(0xFF1E3D23),
    surfaceLight: Color(0xFF264D2D),
  );

  static const roseGold = ThemePreset(
    id: 'rose_gold',
    name: 'Rose Gold',
    emoji: '🌹',
    primaryColor: Color(0xFFFF6B9D),
    secondaryColor: Color(0xFFE84393),
    backgroundDark: Color(0xFF1A0A14),
    backgroundLight: Color(0xFF2D1221),
    surfaceColor: Color(0xFF3E1A2F),
    surfaceLight: Color(0xFF4D2339),
  );

  static const List<ThemePreset> all = [
    navyGold,
    oceanTeal,
    midnightPurple,
    forestGreen,
    roseGold,
  ];

  static ThemePreset getById(String id) {
    return all.firstWhere((t) => t.id == id, orElse: () => navyGold);
  }
}

/// Manages the active theme selection
class ThemeService {
  ThemeService._();
  static final instance = ThemeService._();

  static const _themeKey = 'selected_theme';
  final _db = LocalDatabase.instance;

  String get selectedThemeId {
    if (!_db.isInitialized) return 'navy_gold';
    return _db.settingsBox.get(_themeKey, defaultValue: 'navy_gold');
  }

  ThemePreset get currentTheme => ThemePresets.getById(selectedThemeId);

  Future<void> setTheme(String themeId) async {
    await _db.settingsBox.put(_themeKey, themeId);
  }
}
