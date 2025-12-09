import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/core/core.dart';

/// {@template app_theme}
/// Main theme for the Tô Lendo app.
/// {@endtemplate}
sealed class AppTheme {
  AppTheme._();

  /// Main app theme.
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(primary: AppColors.primaryPurple),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.primaryPurple),
      titleTextStyle: AppTextStyles.heading2,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppButtons.primaryButtonStyle(),
    ),
    textButtonTheme: TextButtonThemeData(style: AppButtons.textButtonStyle()),
    floatingActionButtonTheme: AppButtons.fabTheme(),
    inputDecorationTheme: AppInputs.inputDecorationTheme(),
    textTheme: const TextTheme(
      displayLarge: AppTextStyles.largeTitle,
      displayMedium: AppTextStyles.heading1,
      displaySmall: AppTextStyles.heading2,
      headlineMedium: AppTextStyles.heading3,
      titleLarge: AppTextStyles.bodyLarge,
      titleMedium: AppTextStyles.bodyMedium,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      labelLarge: AppTextStyles.buttonText,
    ),
    cardTheme: CardThemeData(
      color: AppColors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    ),
  );
}
