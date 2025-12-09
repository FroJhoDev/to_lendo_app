import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/core/core.dart';

/// {@template app_separator_widget}
/// Separator widget with "or" text and lines.
/// {@endtemplate}
class AppSeparatorWidget extends StatelessWidget {
  /// {@macro app_separator_widget}
  const AppSeparatorWidget({super.key, this.text = 'ou'});

  /// Separator text.
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: AppColors.grayLight)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Text(
            text,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ),
        Expanded(child: Container(height: 1, color: AppColors.grayLight)),
      ],
    );
  }
}
