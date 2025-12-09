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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selector
            Container(
              padding: const EdgeInsets.all(AppSpacing.xs),
              decoration: BoxDecoration(
                color: const Color(0xFFFFDDC7),
                borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
              ),
              child: Row(
                children: [
                  _buildPeriodButton('Semana', _selectedPeriod == 'Semana'),
                  _buildPeriodButton('Mês', _selectedPeriod == 'Mês'),
                  _buildPeriodButton('Ano', _selectedPeriod == 'Ano'),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            // Key Statistics Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.bookmark_border,
                    label: 'Páginas/Dia',
                    value: '25',
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.local_fire_department_outlined,
                    label: 'Dias Consecutivos',
                    value: '14',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            _buildStatCard(
              icon: Icons.star_border,
              label: 'Livros Concluídos',
              value: '5',
              fullWidth: true,
            ),
            const SizedBox(height: AppSpacing.md),
            // Monthly Pages Read Card
            AppCardWidget(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildChartBar(60),
                        _buildChartBar(80),
                        _buildChartBar(40),
                        _buildChartBar(90),
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
            const SizedBox(height: AppSpacing.md),
            // Completion Estimates
            const Text('Estimativa de Término', style: AppTextStyles.heading3),
            const SizedBox(height: AppSpacing.sm),
            _buildCompletionEstimateItem(
              'A Arte da Guerra',
              '15 de Agosto',
              '85%',
            ),
            const SizedBox(height: AppSpacing.xs),
            _buildCompletionEstimateItem('O Hobbit', '29 de Setembro', '42%'),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodButton(String period, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedPeriod = period;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.orange : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
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

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    bool fullWidth = false,
  }) {
    return AppCardWidget(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primaryPurpleDark, size: 24),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: AppTextStyles.heading1.copyWith(
              fontSize: 32,
              color: AppColors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartBar(double height) {
    return Container(
      width: 40,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFFFC4A3),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
      ),
    );
  }

  Widget _buildCompletionEstimateItem(
    String title,
    String date,
    String progress,
  ) {
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
              color: const Color(0xFFFFC4A3),
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
