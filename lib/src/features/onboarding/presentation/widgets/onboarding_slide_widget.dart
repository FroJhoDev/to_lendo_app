import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template onboarding_slide_widget}
/// Widget for each onboarding slide.
/// {@endtemplate}
class OnboardingSlideWidget extends StatelessWidget {
  /// {@macro onboarding_slide_widget}
  const OnboardingSlideWidget({
    super.key,
    required this.title,
    required this.description,
    required this.illustration,
  });

  /// Slide title.
  final String title;

  /// Slide description.
  final String description;

  /// Slide illustration widget.
  final Widget illustration;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top section with peach background
        Expanded(
          flex: 5,
          child: Container(
            width: double.infinity,
            color: AppColors.peachBackground,
            child: Center(child: illustration),
          ),
        ),
        // Bottom section with beige background
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            color: AppColors.peachBackgroundAlt,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppTextStyles.largeTitle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  description,
                  style: AppTextStyles.orangeText,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
