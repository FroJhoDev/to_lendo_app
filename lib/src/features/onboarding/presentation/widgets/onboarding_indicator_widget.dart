import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template onboarding_indicator_widget}
/// Page indicator widget (dots) for onboarding.
/// {@endtemplate}
class OnboardingIndicatorWidget extends StatelessWidget {
  /// {@macro onboarding_indicator_widget}
  const OnboardingIndicatorWidget({
    super.key,
    required this.currentIndex,
    required this.totalPages,
  });

  /// Current page index.
  final int currentIndex;

  /// Total number of pages.
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentIndex
                ? AppColors.mediumPurpleAlt
                : AppColors.lightPurpleAlt,
          ),
        ),
      ),
    );
  }
}
