import 'package:flutter/material.dart';
import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/core/core.dart';

/// {@template app_snackbar}
/// Utility class for showing custom snackbars in the app.
/// {@endtemplate}
class AppSnackbar {
  AppSnackbar._();

  /// Shows an error snackbar.
  static void error(BuildContext context, {required String message}) =>
      _show(context: context, message: message, icon: AppIcons.alert, backgroundColor: AppColors.orangeDark);

  /// Shows a success snackbar.
  static void success(BuildContext context, {required String message}) =>
      _show(context: context, message: message, icon: AppIcons.check, backgroundColor: AppColors.success);

  /// Shows an info snackbar.
  static void info(BuildContext context, {required String message}) =>
      _show(context: context, message: message, icon: AppIcons.info, backgroundColor: AppColors.mediumPurple);

  static void _show({
    required BuildContext context,
    required String message,
    required List<List<dynamic>> icon,
    required Color backgroundColor,
  }) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          HugeIcon(icon: icon, color: AppColors.white, size: 28.0),
          const SizedBox(width: AppSpacing.xs),
          Expanded(child: Text(message)),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
