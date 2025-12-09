import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/core/core.dart';

/// {@template app_text_styles}
/// Hierarchical text styles for the Tô Lendo app.
/// {@endtemplate}
sealed class AppTextStyles {
  AppTextStyles._();

  /// Large Titles
  /// Large title (28px, bold)
  static const TextStyle largeTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  /// Headings
  /// Level 1 heading (24px, bold)
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  /// Level 2 heading (20px, bold)
  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  /// Level 3 heading (18px, bold)
  static const TextStyle heading3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  /// Body Text
  /// Large body text (16px, normal)
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  /// Medium body text (14px, normal)
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  /// Small body text (12px, normal)
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textMuted,
  );

  /// Secondary Text
  /// Large secondary text (16px, normal)
  static const TextStyle secondaryLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  /// Medium secondary text (14px, normal)
  static const TextStyle secondaryMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  /// Orange Text (for descriptions)
  /// Orange text for descriptions (14px, normal)
  static const TextStyle orangeText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.orangeDark,
  );

  /// Button Text
  /// Button text (16px, bold)
  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  /// Input Labels
  /// Input label text (14px, bold)
  static const TextStyle inputLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  /// Placeholder Text
  /// Placeholder text (14px, normal)
  static const TextStyle placeholder = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textTertiary,
  );

  /// Link Text
  /// Link text (14px, normal, underlined)
  static const TextStyle link = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryPurpleMedium,
    decoration: TextDecoration.underline,
  );

  /// App Bar Title
  /// App bar title text (20px, normal, black)
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: AppColors.black,
  );

  /// Forgot Password Link
  /// Forgot password link text (14px, normal)
  static const TextStyle forgotPassword = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryPurpleMedium,
  );
}
