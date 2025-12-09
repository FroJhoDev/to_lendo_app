import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template statistics_period_button_widget}
/// Button for selecting a time period in statistics.
/// {@endtemplate}
class StatisticsPeriodButtonWidget extends StatelessWidget {
  /// {@macro statistics_period_button_widget}
  const StatisticsPeriodButtonWidget({
    super.key,
    required this.period,
    required this.isSelected,
    required this.onTap,
  });

  /// Period label.
  final String period;

  /// Whether this period is currently selected.
  final bool isSelected;

  /// Callback when button is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.orange : AppColors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
          ),
          child: Text(
            period,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isSelected ? AppColors.white : AppColors.orangeDark,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
