import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template statistics_chart_bar_widget}
/// Bar widget for statistics chart.
/// {@endtemplate}
class StatisticsChartBarWidget extends StatelessWidget {
  /// {@macro statistics_chart_bar_widget}
  const StatisticsChartBarWidget({super.key, required this.height});

  /// Height of the bar.
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.orangeLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
      ),
    );
  }
}
