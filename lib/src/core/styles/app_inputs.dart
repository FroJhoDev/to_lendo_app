import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/core/core.dart';

/// {@template app_inputs}
/// Input styles for the Tô Lendo app.
/// {@endtemplate}
sealed class AppInputs {
  AppInputs._();

  /// Default input decoration theme
  static InputDecorationTheme inputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
        borderSide: const BorderSide(color: AppColors.primaryPurple),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
        borderSide: const BorderSide(color: AppColors.primaryPurple),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
        borderSide: const BorderSide(
          color: AppColors.primaryPurple,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
        borderSide: const BorderSide(color: AppColors.orange),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
        borderSide: const BorderSide(color: AppColors.orange, width: 2.0),
      ),
      hintStyle: AppTextStyles.placeholder,
      labelStyle: AppTextStyles.inputLabel,
    );
  }

  /// Text style for inputs
  static TextStyle inputTextStyle() {
    return AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary);
  }
}
