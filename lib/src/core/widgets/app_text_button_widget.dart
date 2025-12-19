import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/core/core.dart';

/// {@template app_text_button_widget}
/// Clickable text button widget with style variations.
/// Used for links and tertiary actions.
/// {@endtemplate}
class AppTextButtonWidget extends StatelessWidget {
  /// {@macro app_text_button_widget}
  const AppTextButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    required this.buttonStyle,
    this.isLoading = false,
  });

  /// Orange text button variant.
  AppTextButtonWidget.orange({super.key, required this.text, required this.onPressed, this.isLoading = false})
    : buttonStyle = AppButtons.textButtonStyle();

  /// Purple text button variant.
  AppTextButtonWidget.purple({super.key, required this.text, required this.onPressed, this.isLoading = false})
    : buttonStyle = AppButtons.textButtonPurpleStyle();

  /// Button text.
  final String text;

  /// Callback called when button is pressed.
  final VoidCallback? onPressed;

  /// Whether the button is in loading state.
  final bool isLoading;

  /// Button style.
  final ButtonStyle buttonStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: isLoading ? null : onPressed, style: buttonStyle, child: Text(text));
  }
}
