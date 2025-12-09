import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/core/core.dart';

/// {@template app_progress_bar_widget}
/// Custom progress bar widget.
/// {@endtemplate}
class AppProgressBarWidget extends StatelessWidget {
  /// {@macro app_progress_bar_widget}
  const AppProgressBarWidget({
    super.key,
    required this.progress,
    this.color,
    this.height = 8.0,
  });

  /// Progress from 0.0 to 1.0
  final double progress;

  /// Progress bar color.
  final Color? color;

  /// Progress bar height.
  final double height;

  @override
  Widget build(BuildContext context) {
    final progressColor = color ?? AppColors.orange;
    final clampedProgress = progress.clamp(0.0, 1.0);

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.lightLavender,
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: clampedProgress,
        child: Container(
          decoration: BoxDecoration(
            color: progressColor,
            borderRadius: BorderRadius.circular(height / 2),
          ),
        ),
      ),
    );
  }
}
