import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template reading_history_item_widget}
/// Widget for displaying a reading history item.
/// {@endtemplate}
class ReadingHistoryItemWidget extends StatelessWidget {
  /// {@macro reading_history_item_widget}
  const ReadingHistoryItemWidget({
    super.key,
    required this.action,
    required this.date,
    this.duration,
  });

  /// Action description.
  final String action;

  /// Date of the action.
  final String date;

  /// Optional duration of the reading session.
  final String? duration;

  @override
  Widget build(BuildContext context) {
    return AppCardWidget(
      padding: const EdgeInsets.all(AppSpacing.sm),
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.nano),
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
              Icons.book_outlined,
              color: AppColors.primaryPurpleDark,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  action,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(date, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          if (duration != null) Text(duration!, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}
