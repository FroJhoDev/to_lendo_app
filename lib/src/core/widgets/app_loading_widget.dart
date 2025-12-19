import 'package:flutter/material.dart';
import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/core/core.dart';

/// {@template app_loading_widget}
/// Loading widget with animation, title and subtitle.
/// Used to display loading state in pages.
/// {@endtemplate}
class AppLoadingWidget extends StatelessWidget {
  /// {@macro app_loading_widget}
  const AppLoadingWidget({super.key, required this.title, required this.subtitle});

  /// Loading title text.
  final String title;

  /// Loading subtitle text.
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 200, height: 200, child: Lottie.asset(AppAnimations.loadingAnimation, fit: BoxFit.contain)),
          const SizedBox(height: AppSpacing.lg),
          Text(title, style: AppTextStyles.heading2, textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.xs),
          Text(
            subtitle,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
