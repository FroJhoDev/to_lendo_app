import 'package:flutter/material.dart';

/// {@template app_colors}
/// Tô Lendo app colors extracted from design images.
/// {@endtemplate}
sealed class AppColors {
  AppColors._();

  /// Background Colors
  /// Off-white/light beige
  static const Color background = Color(0xFFF5EDE4);

  /// Background Light
  static const Color backgroundLight = Color(0xFFF9F4EE);

  /// Alternative light beige
  /// Warm beige
  static const Color backgroundWarm = Color(0xFFF5EDE4);

  /// Dark background for light text
  static const Color backgroundDark = Color(0xFF965E1A);

  /// Primary Purple Colors
  /// Main purple
  static const Color primaryPurple = Color(0xFF6B3EFF);

  /// Dark purple.
  static const Color primaryPurpleDark = Color(0xFF4822B8);

  /// Medium purple
  static const Color primaryPurpleMedium = Color(0xFF673AB7);

  /// Medium Purple Colors
  /// Medium purple
  static const Color mediumPurple = Color(0xFF7E57C2);

  /// Alternative medium purple
  static const Color mediumPurpleAlt = Color(0xFF6F3EBE);

  /// Light Purple Colors
  /// Light purple
  static const Color lightPurple = Color(0xFFA28DCE);

  /// Alternative light purple
  static const Color lightPurpleAlt = Color(0xFFBBA8E0);

  /// Orange Colors
  /// Main orange
  static const Color orange = Color(0xFFFF7A32);

  /// Dark orange
  static const Color orangeDark = Color(0xFFD65F24);

  /// Alternative orange
  static const Color orangeAlt = Color(0xFFFF7A32);

  /// Light orange background (period selector)
  static const Color orangeLightBackground = Color(0xFFFFDDC7);

  /// Light orange for charts and badges
  static const Color orangeLight = Color(0xFFFFC4A3);

  /// Light Colors
  static const Color white = Color(0xFFFFFFFF);

  /// Black color for text and icons
  static const Color black = Color(0xFF000000);

  /// Transparent color
  static const Color transparent = Color(0x00000000);

  /// Light lavender (inputs)
  static const Color lightLavender = Color(0xFFF0EBF8);

  /// Alternative light lavender
  static const Color lightLavenderAlt = Color(0xFFEDE7F6);

  /// Peach/Orange Background (Onboarding)
  /// Peach background
  static const Color peachBackground = Color(0xFFF5E0D0);

  /// Alternative peach background
  static const Color peachBackgroundAlt = Color(0xFFF8F2ED);

  /// Gray Colors (Secondary text)
  static const Color gray = Color(0xFF9E9E9E);

  /// Dark gray
  static const Color grayDark = Color(0xFF616161);

  /// Light gray for separators
  static const Color grayLight = Color(0xFFE0D9EC);

  /// Light gray background for unselected chips
  static const Color grayLightBackground = Color(0xFFE5E5E5);

  /// Blue-gray for onboarding indicators
  static const Color blueGray = Color(0xFFD4DDE8);

  /// Success Color
  /// Green for positive changes
  static const Color success = Color(0xFF4CAF50);

  /// Text Colors
  /// Primary color for text
  static const Color textPrimary = primaryPurple;

  /// Secondary color for text
  static const Color textSecondary = mediumPurple;

  /// Tertiary color for text
  static const Color textTertiary = lightPurple;

  /// Color for muted text
  static const Color textMuted = gray;
}
