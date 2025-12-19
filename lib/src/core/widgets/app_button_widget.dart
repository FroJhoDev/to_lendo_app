import 'package:flutter/material.dart';
import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/core/core.dart';

/// {@template app_button_widget}
/// Custom button widget with style variations.
/// Used for primary and secondary actions.
/// {@endtemplate}
class AppButtonWidget extends StatelessWidget {
  /// {@macro app_button_widget}
  const AppButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    required this.shadowColor,
    required this.buttonStyle,
    this.isLoading = false,
  });

  /// Primary button variant (orange).
  AppButtonWidget.primary({super.key, required this.text, required this.onPressed, this.isLoading = false})
    : shadowColor = AppColors.orange,
      buttonStyle = AppButtons.primaryButtonStyle();

  /// Secondary button variant (purple).
  AppButtonWidget.secondary({super.key, required this.text, required this.onPressed, this.isLoading = false})
    : shadowColor = AppColors.primaryPurpleMedium,
      buttonStyle = AppButtons.secondaryButtonStyle();

  /// Button text.
  final String text;

  /// Callback called when button is pressed.
  final VoidCallback? onPressed;

  /// Whether the button is in loading state.
  final bool isLoading;

  /// Shadow color for the button.
  final Color shadowColor;

  /// Button style.
  final ButtonStyle buttonStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
        boxShadow: [BoxShadow(color: shadowColor.withValues(alpha: 0.4), offset: const Offset(0, 4), blurRadius: 8)],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: buttonStyle.copyWith(
          padding: isLoading ? WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero) : null,
        ),
        child: isLoading
            ? SizedBox(
                height: 50,
                width: 50,
                child: Lottie.asset(AppAnimations.bookLoaderAnimation, fit: BoxFit.contain),
              )
            : Text(text, style: AppTextStyles.buttonText),
      ),
    );
  }
}
