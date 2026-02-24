import 'package:flutter/material.dart';

/// Application theme configuration - Premium Gold/Navy theme
class AppTheme {
  AppTheme._();

  // Colors - Gold/Amber Brand Identity
  static const Color primaryColor = Color(0xFFFFD700);       // Gold
  static const Color secondaryColor = Color(0xFFFFC107);     // Amber
  static const Color accentColor = Color(0xFFFFD700);        // Gold
  static const Color successColor = Color(0xFF00C9A7);       // Emerald
  static const Color errorColor = Color(0xFFFF6B6B);         // Coral
  static const Color warningColor = Color(0xFFFFA726);       // Orange

  // Background Colors
  static const Color backgroundDark = Color(0xFF0D1B2A);     // Deep Navy
  static const Color backgroundLight = Color(0xFF1B263B);    // Navy
  static const Color surfaceColor = Color(0xFF1E3A5F);       // Slate
  static const Color surfaceLight = Color(0xFF254670);       // Lighter Slate

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0BEC5);
  static const Color textMuted = Color(0xFF607D8B);
  static const Color textGold = Color(0xFFFFD700);

  // Tile Colors
  static const Color tileEmpty = Color(0xFF1E3A5F);
  static const Color tileFilled = Color(0xFF2A4A6B);
  static const Color tileSelected = Color(0xFFFFD700);
  static const Color tileCorrect = Color(0xFF00C9A7);
  static const Color tileWrong = Color(0xFFFF6B6B);

  // Difficulty Colors
  static const Color easyColor = Color(0xFF81C784);
  static const Color mediumColor = Color(0xFF64B5F6);
  static const Color hardColor = Color(0xFFFFB74D);
  static const Color expertColor = Color(0xFFE57373);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFFFD700), Color(0xFFFFA000)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [backgroundDark, backgroundLight],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFFFD700), Color(0xFFFFC107), Color(0xFFFF8F00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [Color(0xFF1E3A5F), Color(0xFF254670)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

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
      colorScheme: const ColorScheme.dark(
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
