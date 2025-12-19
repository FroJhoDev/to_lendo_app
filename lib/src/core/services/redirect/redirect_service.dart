/// {@template redirect_service}
/// Service responsible for managing app navigation redirects based on
/// first open status and authentication state.
/// {@endtemplate}
abstract interface class RedirectService {
  /// Checks if this is the first time the app is opened.
  Future<void> checkFirstOpen();

  /// Marks the onboarding as completed.
  Future<void> markOnboardingCompleted();

  /// Returns whether this is the first time opening the app.
  bool get isFirstOpen;

  /// Returns the initial route based on app state.
  String getInitialRoute();

  /// Returns whether the user is authenticated.
  Future<bool> isAuthenticated();
}
