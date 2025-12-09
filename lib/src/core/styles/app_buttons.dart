import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/core/core.dart';

/// {@template app_buttons}
/// Button styles for the Tô Lendo app.
/// {@endtemplate}
sealed class AppButtons {
  AppButtons._();

  /// Primary button (orange) - used for main actions
  static ButtonStyle primaryButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.orange,
      foregroundColor: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      textStyle: AppTextStyles.buttonText,
    );
  }

  /// Secondary button (purple) - used for secondary actions
  static ButtonStyle secondaryButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryPurpleMedium,
      foregroundColor: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      textStyle: AppTextStyles.buttonText,
    );
  }

  /// Text button - used for links and tertiary actions
  static ButtonStyle textButtonStyle() {
    return TextButton.styleFrom(
      foregroundColor: AppColors.orangeAlt,
      textStyle: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    );
  }

  /// Purple text button - used for secondary links
  static ButtonStyle textButtonPurpleStyle() {
    return TextButton.styleFrom(
      foregroundColor: AppColors.primaryPurpleMedium,
      textStyle: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    );
  }

  /// FAB (Floating Action Button) - orange with + icon
  static FloatingActionButtonThemeData fabTheme() {
    return FloatingActionButtonThemeData(
      backgroundColor: AppColors.orange,
      foregroundColor: AppColors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      ),
    );
  }
}
