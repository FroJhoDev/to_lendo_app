import 'package:flutter/material.dart';
import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/core/core.dart';

/// {@template app_star_rating_widget}
/// Star rating widget.
/// {@endtemplate}
class AppStarRatingWidget extends StatelessWidget {
  /// {@macro app_star_rating_widget}
  const AppStarRatingWidget({super.key, required this.rating, this.starSize = 28.0, this.onRatingChanged});

  /// Rating from 0 to 5
  final double rating;

  /// Star size.
  final double starSize;

  /// Callback called when rating changes.
  final ValueChanged<double>? onRatingChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starValue = index + 1.0;
        final isFilled = starValue <= rating;
        final isHalfFilled = starValue - 0.5 <= rating && rating < starValue;

        return GestureDetector(
          onTap: onRatingChanged != null ? () => onRatingChanged!(starValue) : null,
          child: Padding(
            padding: const EdgeInsets.only(right: AppSpacing.xs),
            child: HugeIcon(
              icon: isFilled
                  ? AppIcons.starFilled
                  : isHalfFilled
                  ? AppIcons.starHalf
                  : AppIcons.starOutlined,
              color: AppColors.orange,
              size: starSize,
            ),
          ),
        );
      }),
    );
  }
}
