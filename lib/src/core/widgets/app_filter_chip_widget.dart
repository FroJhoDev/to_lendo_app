import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/core/core.dart';

/// {@template app_filter_chip_widget}
/// Filter chip widget with active/inactive states.
/// {@endtemplate}
class AppFilterChipWidget extends StatelessWidget {
  /// {@macro app_filter_chip_widget}
  const AppFilterChipWidget({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  /// Chip label.
  final String label;

  /// Whether the chip is selected.
  final bool isSelected;

  /// Callback called when selection changes.
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onSelected,
      backgroundColor: AppColors.grayLightBackground,
      selectedColor: AppColors.orange,
      showCheckmark: false,
      labelStyle: AppTextStyles.bodyMedium.copyWith(
        color: isSelected ? AppColors.white : Colors.black,
        fontWeight: FontWeight.bold,
      ),

      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      side: BorderSide.none,
    );
  }
}
