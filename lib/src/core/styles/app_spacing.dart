/// {@template app_spacing}
/// Consistent spacing system for the Tô Lendo app.
/// {@endtemplate}
sealed class AppSpacing {
  AppSpacing._();

  /// Nano spacing (4.0)
  static const double nano = 4.0;

  /// Extra extra small spacing (8.0)
  static const double xxs = 8.0;

  /// Extra small spacing (12.0)
  static const double xs = 12.0;

  /// Small spacing (16.0)
  static const double sm = 16.0;

  /// Medium spacing (24.0)
  static const double md = 24.0;

  /// Large spacing (32.0)
  static const double lg = 32.0;

  /// Extra large spacing (48.0)
  static const double xl = 48.0;

  /// Extra extra large spacing (64.0)
  static const double xxl = 64.0;

  /// Border Radius
  /// Small border radius (8.0)
  static const double radiusSmall = 8.0;

  /// Medium border radius (16.0)
  static const double radiusMedium = 16.0;

  /// Large border radius (24.0)
  static const double radiusLarge = 24.0;

  /// Extra large border radius (30.0)
  static const double radiusXLarge = 30.0;

  /// Input and Button specific
  /// Normalized border radius for inputs and buttons (12.0)
  static const double inputRadius = 12.0;

  /// Normalized border radius for buttons (same as inputs)
  static const double buttonRadius = 12.0;

  /// Rounded borders for cards (20.0)
  static const double cardRadius = 20.0;

  /// Pill shape border radius for chips and buttons (50.0)
  static const double pillRadius = 50.0;
}
