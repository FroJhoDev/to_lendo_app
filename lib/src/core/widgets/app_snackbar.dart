import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/core/styles/app_colors.dart';

/// {@template app_snackbar}
/// Utility class for showing custom snackbars in the app.
/// {@endtemplate}
class AppSnackbar {
  AppSnackbar._();

  /// Shows an error snackbar.
  static void error(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.orangeDark,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Shows a success snackbar.
  static void success(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Shows an info snackbar.
  static void info(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.mediumPurple,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
