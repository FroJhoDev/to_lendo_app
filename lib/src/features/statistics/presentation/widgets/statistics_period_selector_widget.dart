import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template statistics_period_selector_widget}
/// Period selector widget for statistics page.
/// {@endtemplate}
class StatisticsPeriodSelectorWidget extends StatelessWidget {
  /// {@macro statistics_period_selector_widget}
  const StatisticsPeriodSelectorWidget({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  /// Currently selected period.
  final String selectedPeriod;

  /// Callback when period changes.
  final ValueChanged<String> onPeriodChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.nano),
      decoration: BoxDecoration(
        color: AppColors.orangeLightBackground,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          StatisticsPeriodButtonWidget(
            period: 'Semana',
            isSelected: selectedPeriod == 'Semana',
            onTap: () => onPeriodChanged('Semana'),
          ),
          StatisticsPeriodButtonWidget(
            period: 'Mês',
            isSelected: selectedPeriod == 'Mês',
            onTap: () => onPeriodChanged('Mês'),
          ),
          StatisticsPeriodButtonWidget(
            period: 'Ano',
            isSelected: selectedPeriod == 'Ano',
            onTap: () => onPeriodChanged('Ano'),
          ),
        ],
      ),
    );
  }
}
