import 'package:flutter/foundation.dart';
import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template redirect_service_impl}
/// Implementation of [RedirectService] using Flutter Secure Storage.
/// {@endtemplate}
class RedirectServiceImpl implements RedirectService {
  /// {@macro redirect_service_impl}
  RedirectServiceImpl({required FlutterSecureStorage secureStorage}) : _secureStorage = secureStorage;

  final FlutterSecureStorage _secureStorage;
  static const String _firstOpenKey = 'first_open';

  bool _isFirstOpen = true;

  @override
  Future<void> checkFirstOpen() async {
    try {
      final value = await _secureStorage.read(key: _firstOpenKey);
      _isFirstOpen = value != 'false';
    } catch (error) {
      // If there's an error reading, assume first open
      _isFirstOpen = true;
      debugPrint('Error reading first_open flag: $error');
    }
  }

  @override
  Future<void> markOnboardingCompleted() async {
    try {
      await _secureStorage.write(key: _firstOpenKey, value: 'false');
      _isFirstOpen = false;
    } catch (error) {
      debugPrint('Error writing first_open flag: $error');
      // Re-throw to let caller handle the error if needed
      rethrow;
    }
  }

  @override
  bool get isFirstOpen => _isFirstOpen;

  @override
  String getInitialRoute() {
    if (_isFirstOpen) {
      return AppRoutes.onboarding.path;
    }

    // Authentication check is done asynchronously in the router
    // Default to auth page, router will redirect if authenticated
    return AppRoutes.auth.path;
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      final authRepository = injection<AuthRepository>();
      final result = await authRepository.getCurrentUser();
      return result.fold((_) => false, (UserModel? user) => user != null);
    } catch (error) {
      debugPrint('Error checking authentication: $error');
      return false;
    }
  }
}
