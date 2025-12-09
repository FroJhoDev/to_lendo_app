import 'package:flutter/material.dart';
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
  final IconData? icon;

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
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTextStyles.placeholder,
            prefixIcon: widget.icon != null
                ? Icon(widget.icon, color: AppColors.mediumPurple)
                : null,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.mediumPurple,
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
