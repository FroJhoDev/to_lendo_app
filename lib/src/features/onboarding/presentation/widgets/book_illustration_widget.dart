import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template book_illustration_widget}
/// Book illustration widget for onboarding slides.
/// {@endtemplate}
class BookIllustrationWidget extends StatelessWidget {
  /// {@macro book_illustration_widget}
  const BookIllustrationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Book pages
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.all(AppSpacing.xxs),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSpacing.nano),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(AppSpacing.xs),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 4,
                            color: AppColors.black.withValues(alpha: 0.1),
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Container(
                            width: 60,
                            height: 4,
                            color: AppColors.black.withValues(alpha: 0.1),
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Container(
                            width: double.infinity,
                            height: 4,
                            color: AppColors.black.withValues(alpha: 0.1),
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Container(
                            width: 80,
                            height: 4,
                            color: AppColors.black.withValues(alpha: 0.1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Book spine
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 8,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.blueGray,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSpacing.xxs),
                  bottomLeft: Radius.circular(AppSpacing.xxs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
