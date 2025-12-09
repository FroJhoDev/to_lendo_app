import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/core/core.dart';

/// {@template app_book_card_widget}
/// Book card widget for list.
/// {@endtemplate}
class AppBookCardWidget extends StatelessWidget {
  /// {@macro app_book_card_widget}
  const AppBookCardWidget({
    super.key,
    required this.title,
    required this.author,
    required this.progress,
    required this.totalPages,
    required this.pagesRead,
    this.coverImage,
    this.isCompleted = false,
    this.onTap,
  });

  /// Book title.
  final String title;

  /// Book author.
  final String author;

  /// Reading progress from 0.0 to 1.0.
  final double progress;

  /// Total book pages.
  final int totalPages;

  /// Pages read.
  final int pagesRead;

  /// Book cover image URL.
  final String? coverImage;

  /// Whether the book is completed.
  final bool isCompleted;

  /// Callback called when card is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppCardWidget(
          onTap: onTap,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTextStyles.heading3.copyWith(
                            color: AppColors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          author,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.backgroundDark,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Container(
                    width: 80,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.lightLavender,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusSmall,
                      ),
                      border: Border.all(
                        color: AppColors.primaryPurple.withValues(alpha: 0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusSmall,
                      ),
                      child: coverImage != null
                          ? Image.network(
                              coverImage ?? '',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const AppBookPlaceholderWidget(),
                            )
                          : const AppBookPlaceholderWidget(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              if (isCompleted)
                Row(
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: AppColors.primaryPurpleMedium,
                      size: 16,
                    ),
                    const SizedBox(width: AppSpacing.nano),
                    Text(
                      'Concluído',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primaryPurpleMedium,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isCompleted
                            ? AppColors.primaryPurpleMedium
                            : AppColors.orange,
                      ),
                    ),
                    Text(
                      '$pagesRead/$totalPages páginas',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.backgroundDark,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: AppSpacing.nano),
              SizedBox(
                width: double.infinity,
                child: AppProgressBarWidget(
                  progress: progress,
                  color: isCompleted
                      ? AppColors.primaryPurpleMedium
                      : AppColors.orange,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
      ],
    );
  }
}
