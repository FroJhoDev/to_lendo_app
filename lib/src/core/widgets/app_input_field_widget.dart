import 'package:flutter/material.dart';
import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/core/core.dart';

/// {@template app_input_field_widget}
/// Custom input field widget with icon.
/// {@endtemplate}
class AppInputFieldWidget extends StatefulWidget {
  /// {@macro app_input_field_widget}
  const AppInputFieldWidget({
    super.key,
    required this.label,
    required this.hint,
    this.icon,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.keyboardType,
    this.onChanged,
  });

  /// Input field label.
  final String label;

  /// Input field hint text.
  final String hint;

  /// Optional icon for the input field.
  final List<List<dynamic>>? icon;

  /// Whether the field should hide text (for passwords).
  final bool obscureText;

  /// Optional controller for the input field.
  final TextEditingController? controller;

  /// Optional validation function.
  final String? Function(String?)? validator;

  /// Optional keyboard type.
  final TextInputType? keyboardType;

  /// Callback called when text changes.
  final ValueChanged<String>? onChanged;

  @override
  State<AppInputFieldWidget> createState() => _AppInputFieldWidgetState();
}

class _AppInputFieldWidgetState extends State<AppInputFieldWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.xs),
          child: Text(widget.label, style: AppTextStyles.inputLabel),
        ),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.obscureText && _obscureText,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.black),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTextStyles.placeholder,
            prefixIconConstraints: const BoxConstraints(minWidth: 20.0, minHeight: 20.0),
            prefixIcon: widget.icon != null
                ? Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.xs, right: AppSpacing.nano),
                    child: HugeIcon(icon: widget.icon ?? [], color: AppColors.mediumPurple, size: 20.0),
                  )
                : null,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: HugeIcon(
                      icon: _obscureText ? AppIcons.visibilityOn : AppIcons.visibilityOff,
                      color: AppColors.mediumPurple,
                      size: 20.0,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
