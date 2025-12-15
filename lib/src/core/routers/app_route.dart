import 'package:flutter/material.dart';
import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template app_route}
/// Application routes configuration using GoRouter.
/// {@endtemplate}
class AppRoute {
  AppRoute._();

  // TODO(team): Implement with RedirectService when available
  /// Check if user has completed onboarding
  static bool get _isFirstOpen => true;

  // TODO(team): Implement with AuthService when available
  /// Check if user is logged in
  static bool get _isLoggedIn => false;

  /// Initial route based on app state
  static String get _initialLocation {
    if (_isFirstOpen) {
      return AppRoutes.onboarding.path;
    }
    return _isLoggedIn ? AppRoutes.home.path : AppRoutes.auth.path;
  }

  /// Redirect logic for navigation
  static String? _redirect(BuildContext context, GoRouterState state) {
    final isOnboarding = state.matchedLocation == AppRoutes.onboarding.path;
    final isAuth = state.matchedLocation == AppRoutes.auth.path;
    final isHome = state.matchedLocation == AppRoutes.home.path;

    // Allow navigation to onboarding only if it's the initial route
    // Once user moves past onboarding, don't redirect back
    if (isOnboarding) {
      return null; // Allow onboarding to be shown
    }

    // Skip redirect if already on auth and not logged in
    if (isAuth && !_isLoggedIn) {
      return null;
    }

    // Skip redirect if already on home
    if (isHome) {
      return null;
    }

    // Only redirect to onboarding on initial load if first open
    // After that, allow normal navigation flow
    // This prevents redirecting back to onboarding when user navigates to other routes

    // Redirect to auth if not logged in and not on onboarding/auth
    if (!_isLoggedIn && !isAuth && !isOnboarding) {
      return AppRoutes.auth.path;
    }

    // Redirect to home if logged in and on auth
    if (_isLoggedIn && isAuth) {
      return AppRoutes.home.path;
    }

    return null;
  }

  /// Configured GoRouter instance
  static final GoRouter routes = GoRouter(
    initialLocation: _initialLocation,
    debugLogDiagnostics: true,
    redirect: _redirect,
    routes: [
      GoRoute(
        path: AppRoutes.onboarding.path,
        builder: (_, __) => const OnboardingPage(),
      ),
      GoRoute(path: AppRoutes.auth.path, builder: (_, __) => const AuthPage()),
      GoRoute(path: AppRoutes.home.path, builder: (_, __) => const HomePage()),
      GoRoute(
        path: AppRoutes.addBook.path,
        builder: (_, __) => Scaffold(
          appBar: AppBar(title: const Text('Adicionar Livro')),
          body: const Center(child: Text('Add Book Page - To be implemented')),
        ),
      ),
      GoRoute(
        path: AppRoutes.bookDetails.path,
        builder: (context, state) {
          // TODO(team): Retrieve book by ID when BookModel is implemented.
          // For now, we'll pass null as book.
          return const BookDetailsPage(book: null);
        },
      ),
      GoRoute(
        path: AppRoutes.profile.path,
        builder: (_, __) => const ProfilePage(),
      ),
      GoRoute(
        path: AppRoutes.statistics.path,
        builder: (_, __) => const StatisticsPage(),
      ),
    ],
  );
}
