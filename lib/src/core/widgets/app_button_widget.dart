import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/core/core.dart';

/// {@template app_button_widget}
/// Custom button widget with style variations.
/// {@endtemplate}
class AppButtonWidget extends StatelessWidget {
  /// {@macro app_button_widget}
  const AppButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
  });

  /// Button text.
  final String text;

  /// Callback called when button is pressed.
  final VoidCallback? onPressed;

  /// Button variant.
  final ButtonVariant variant;

  /// Whether the button is in loading state.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case ButtonVariant.primary:
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
            boxShadow: [
              BoxShadow(
                color: AppColors.orange.withValues(alpha: 0.4),
                offset: const Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: AppButtons.primaryButtonStyle(),
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(text, style: AppTextStyles.buttonText),
          ),
        );

      case ButtonVariant.secondary:
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryPurpleMedium.withValues(alpha: 0.4),
                offset: const Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: AppButtons.secondaryButtonStyle(),
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(text, style: AppTextStyles.buttonText),
          ),
        );

      case ButtonVariant.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: AppButtons.textButtonStyle(),
          child: Text(text),
        );

      case ButtonVariant.textPurple:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: AppButtons.textButtonPurpleStyle(),
          child: Text(text),
        );
    }
  }
}

/// Available button variants
enum ButtonVariant {
  /// Primary button
  primary,

  /// Secondary button
  secondary,

  /// Text button
  text,

  /// Purple text button
  textPurple,
}
