import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/core/core.dart';

/// {@template app_card_widget}
/// Reusable card widget with app's default style.
/// {@endtemplate}
class AppCardWidget extends StatelessWidget {
  /// {@macro app_card_widget}
  const AppCardWidget({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
  });

  /// Card child widget.
  final Widget child;

  /// Internal card padding.
  final EdgeInsets? padding;

  /// External card margin.
  final EdgeInsets? margin;

  /// Callback called when card is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      margin:
          margin ??
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(AppSpacing.sm),
            child: child,
          ),
        ),
      ),
    );

    return card;
  }
}
