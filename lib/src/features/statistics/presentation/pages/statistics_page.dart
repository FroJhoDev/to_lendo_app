import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template statistics_page}
/// Reading statistics page.
/// {@endtemplate}
class StatisticsPage extends StatefulWidget {
  /// {@macro statistics_page}
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  String _selectedPeriod = 'Mês';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Estatísticas'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selector
            StatisticsPeriodSelectorWidget(
              selectedPeriod: _selectedPeriod,
              onPeriodChanged: (period) {
                setState(() {
                  _selectedPeriod = period;
                });
              },
            ),
            const SizedBox(height: AppSpacing.md),
            // Key Statistics Cards
            const Row(
              children: [
                Expanded(
                  child: StatisticsCardWidget(
                    icon: Icons.bookmark_border,
                    label: 'Páginas/Dia',
                    value: '25',
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: StatisticsCardWidget(
                    icon: Icons.local_fire_department_outlined,
                    label: 'Dias Consecutivos',
                    value: '14',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            const SizedBox(
              width: double.infinity,
              child: StatisticsCardWidget(
                icon: Icons.star_border,
                label: 'Livros Concluídos',
                value: '5',
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            // Monthly Pages Read Card
            SizedBox(
              width: double.infinity,
              child: AppCardWidget(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Páginas Lidas este Mês',
                      style: AppTextStyles.heading3,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      '750',
                      style: AppTextStyles.heading1.copyWith(
                        fontSize: 48,
                        color: AppColors.orange,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '1 - 31 de Julho',
                          style: AppTextStyles.bodySmall,
                        ),
                        Text(
                          '+15%',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    // Placeholder for chart
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.lightLavender,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusSmall,
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          StatisticsChartBarWidget(height: 60),
                          StatisticsChartBarWidget(height: 80),
                          StatisticsChartBarWidget(height: 40),
                          StatisticsChartBarWidget(height: 90),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('S1', style: AppTextStyles.bodySmall),
                        Text('S2', style: AppTextStyles.bodySmall),
                        Text('S3', style: AppTextStyles.bodySmall),
                        Text('S4', style: AppTextStyles.bodySmall),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            // Completion Estimates
            const Text('Estimativa de Término', style: AppTextStyles.heading3),
            const SizedBox(height: AppSpacing.sm),
            const SizedBox(
              width: double.infinity,
              child: StatisticsCompletionEstimateWidget(
                title: 'A Arte da Guerra',
                date: '15 de Agosto',
                progress: '85%',
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            const SizedBox(
              width: double.infinity,
              child: StatisticsCompletionEstimateWidget(
                title: 'O Hobbit',
                date: '29 de Setembro',
                progress: '42%',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
