import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template statistics_completion_estimate_widget}
/// Widget for displaying book completion estimate.
/// {@endtemplate}
class StatisticsCompletionEstimateWidget extends StatelessWidget {
  /// {@macro statistics_completion_estimate_widget}
  const StatisticsCompletionEstimateWidget({
    super.key,
    required this.title,
    required this.date,
    required this.progress,
  });

  /// Book title.
  final String title;

  /// Estimated completion date.
  final String date;

  /// Progress percentage.
  final String progress;

  @override
  Widget build(BuildContext context) {
    return AppCardWidget(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.lightLavenderAlt,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.bookmark_border,
              color: AppColors.primaryPurpleDark,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(date, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.orangeLight,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            ),
            child: Text(
              progress,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
