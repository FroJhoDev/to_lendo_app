import 'package:flutter/material.dart';
import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/injections.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template app_route}
/// Application routes configuration using GoRouter.
/// {@endtemplate}
class AppRoute {
  AppRoute._();

  static RedirectService get _redirectService {
    return injection<RedirectService>();
  }

  /// Initial route based on app state
  static String get _initialLocation {
    return _redirectService.getInitialRoute();
  }

  /// Redirect logic for navigation
  static Future<String?> _redirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    final redirectService = _redirectService;
    final isAuthenticated = await redirectService.isAuthenticated();
    final isFirstOpen = redirectService.isFirstOpen;

    final isOnboarding = state.matchedLocation == AppRoutes.onboarding.path;
    final isAuth = state.matchedLocation == AppRoutes.auth.path;
    final isRegister = state.matchedLocation == AppRoutes.register.path;
    final isHome = state.matchedLocation == AppRoutes.home.path;

    // Allow navigation to onboarding only if it's the first open
    if (isOnboarding) {
      if (!isFirstOpen) {
        // If onboarding was already completed, redirect to auth
        return AppRoutes.auth.path;
      }
      return null; // Allow onboarding to be shown
    }

    // Skip redirect if already on auth and not logged in
    if (isAuth && !isAuthenticated) {
      return null;
    }

    // Skip redirect if already on register and not logged in
    if (isRegister && !isAuthenticated) {
      return null;
    }

    // Skip redirect if already on home
    if (isHome && isAuthenticated) {
      return null;
    }

    // Redirect to auth if not logged in and not on onboarding/auth/register
    if (!isAuthenticated && !isAuth && !isOnboarding && !isRegister) {
      return AppRoutes.auth.path;
    }

    // Redirect to home if logged in and on auth/register
    if (isAuthenticated && (isAuth || isRegister)) {
      return AppRoutes.home.path;
    }

    // Redirect to auth if trying to access protected routes without authentication
    if (!isAuthenticated && !isAuth && !isOnboarding && !isRegister) {
      return AppRoutes.auth.path;
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
      GoRoute(
        path: AppRoutes.register.path,
        builder: (_, __) => const RegisterPage(),
      ),
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
