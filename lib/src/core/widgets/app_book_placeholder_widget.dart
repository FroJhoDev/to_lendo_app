import 'package:flutter/material.dart';
import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/core/core.dart';

/// {@template app_book_placeholder_widget}
/// Placeholder widget for book cover when image is not available.
/// {@endtemplate}
class AppBookPlaceholderWidget extends StatelessWidget {
  /// {@macro app_book_placeholder_widget}
  const AppBookPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: AppColors.lightLavender,
      child: Center(
        child: HugeIcon(icon: AppIcons.book, color: AppColors.mediumPurple, size: 32),
      ),
    );
  }
}
