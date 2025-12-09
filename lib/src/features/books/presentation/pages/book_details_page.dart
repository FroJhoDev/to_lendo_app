import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template book_details_page}
/// Book details page.
/// {@endtemplate}
class BookDetailsPage extends StatelessWidget {
  /// {@macro book_details_page}
  const BookDetailsPage({super.key, required this.book});

  /// The book to display details for.
  final Map<String, dynamic>? book;

  // Mock data if no book provided
  Map<String, dynamic> get _book {
    return book ??
        {
          'title': 'O Hobbit',
          'author': 'J.R.R. Tolkien',
          'pagesRead': 150,
          'totalPages': 300,
          'rating': 4.0,
          'estimatedCompletion': '5 dias',
        };
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_book['pagesRead'] as int) / (_book['totalPages'] as int);
    final rating = _book['rating'] ?? 0.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Detalhes do Livro'),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.nano,
        ),
        child: Column(
          children: [
            AppCardWidget(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: AppColors.lightLavender,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusSmall,
                      ),
                    ),
                    child: const Icon(
                      Icons.book,
                      size: 100,
                      color: AppColors.mediumPurple,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              _book['title'] as String,
              style: AppTextStyles.heading1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.nano),
            Text(
              _book['author'] as String,
              style: AppTextStyles.orangeText.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            AppCardWidget(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progresso',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryPurple,
                        ),
                      ),
                      Text(
                        '${_book['pagesRead']} / ${_book['totalPages']} páginas',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryPurple,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  SizedBox(
                    width: double.infinity,
                    child: AppProgressBarWidget(
                      progress: progress,
                      color: AppColors.orange,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Estimativa de término: ${_book['estimatedCompletion']}',
                    style: AppTextStyles.orangeText,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Minha Avaliação',
                        style: AppTextStyles.heading3,
                      ),
                      const SizedBox(height: AppSpacing.nano),
                      AppStarRatingWidget(rating: rating as double),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Histórico de Leitura', style: AppTextStyles.heading3),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.nano),
            _buildReadingHistoryItem('Leu 25 páginas', 'Hoje', '15 min'),
            _buildReadingHistoryItem('Leu 30 páginas', 'Ontem', '20 min'),
            _buildReadingHistoryItem('Começou a ler', '25/07/2024', null),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: AppColors.orange,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Funcionalidade de registrar leitura em desenvolvimento',
                  ),
                ),
              );
            },
            customBorder: const CircleBorder(),
            child: const Icon(Icons.add, color: AppColors.white, size: 32),
          ),
        ),
      ),
    );
  }

  Widget _buildReadingHistoryItem(
    String action,
    String date,
    String? duration,
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
          if (duration != null) Text(duration, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}
