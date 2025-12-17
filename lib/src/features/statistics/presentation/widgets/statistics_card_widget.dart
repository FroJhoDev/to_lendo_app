import 'package:flutter/material.dart';
import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template statistics_card_widget}
/// Card widget for displaying statistics information.
/// {@endtemplate}
class StatisticsCardWidget extends StatelessWidget {
  /// {@macro statistics_card_widget}
  const StatisticsCardWidget({super.key, required this.icon, required this.label, required this.value});

  /// Icon to display.
  final List<List<dynamic>> icon;

  /// Label text.
  final String label;

  /// Value to display.
  final String value;

  @override
  Widget build(BuildContext context) {
    return AppCardWidget(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HugeIcon(icon: icon, color: AppColors.primaryPurpleDark),
          const SizedBox(height: AppSpacing.sm),
          Text(label, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary)),
          const SizedBox(height: AppSpacing.xs),
          Text(value, style: AppTextStyles.heading1.copyWith(fontSize: 32, color: AppColors.orange)),
        ],
      ),
    );
  }
}
