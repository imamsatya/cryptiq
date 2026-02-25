import 'package:flutter/material.dart';
import 'theme_presets.dart';

/// Application theme configuration
/// Reads from the active ThemePreset for dynamic theming.
class AppTheme {
  AppTheme._();

  static ThemePreset get _t => ThemeService.instance.currentTheme;

  // Colors — dynamic from preset
  static Color get primaryColor => _t.primaryColor;
  static Color get secondaryColor => _t.secondaryColor;
  static Color get accentColor => _t.primaryColor;
  static const Color successColor = Color(0xFF00C9A7);
  static const Color errorColor = Color(0xFFFF6B6B);
  static const Color warningColor = Color(0xFFFFA726);

  // Background Colors
  static Color get backgroundDark => _t.backgroundDark;
  static Color get backgroundLight => _t.backgroundLight;
  static Color get surfaceColor => _t.surfaceColor;
  static Color get surfaceLight => _t.surfaceLight;

  // Text Colors — fixed
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0BEC5);
  static const Color textMuted = Color(0xFF607D8B);
  static Color get textGold => _t.primaryColor;

  // Tile Colors
  static Color get tileEmpty => _t.surfaceColor;
  static Color get tileFilled => _t.surfaceLight;
  static Color get tileSelected => _t.primaryColor;
  static const Color tileCorrect = Color(0xFF00C9A7);
  static const Color tileWrong = Color(0xFFFF6B6B);

  // Difficulty Colors — fixed
  static const Color easyColor = Color(0xFF81C784);
  static const Color mediumColor = Color(0xFF64B5F6);
  static const Color hardColor = Color(0xFFFFB74D);
  static const Color expertColor = Color(0xFFE57373);

  // Gradients
  static LinearGradient get primaryGradient => _t.accentGradient;
  static LinearGradient get backgroundGradient => _t.backgroundGradient;
  static LinearGradient get goldGradient => _t.goldGradient;
  static LinearGradient get surfaceGradient => _t.surfaceGradient;

  // Glassmorphism decoration
  static BoxDecoration glassDecoration({
    double borderRadius = 16,
    Color? borderColor,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      color: surfaceColor.withValues(alpha: 0.6),
      border: Border.all(
        color: borderColor ?? Colors.white.withValues(alpha: 0.1),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
          blurRadius: 20,
          spreadRadius: -5,
        ),
      ],
    );
  }

  // Gold glow decoration
  static BoxDecoration goldGlowDecoration({double borderRadius = 16}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      gradient: goldGradient,
      boxShadow: [
        BoxShadow(
          color: primaryColor.withValues(alpha: 0.4),
          blurRadius: 20,
          spreadRadius: -2,
        ),
      ],
    );
  }

  /// Get the main theme data
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundDark,
      primaryColor: primaryColor,
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: errorColor,
      ),
      textTheme: Typography.material2021(platform: TargetPlatform.android).white.apply(
        fontFamily: 'Poppins',
        bodyColor: textPrimary,
        displayColor: textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: backgroundDark,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
