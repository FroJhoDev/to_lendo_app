import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/src.dart';

/// GetIt instance
final injection = GetIt.instance;

/// Initializes dependency injection for the application.
Future<void> initInjection() async {
  // Secure Storage instance
  const secureStorage = FlutterSecureStorage();

  // Core Services
  injection.registerLazySingleton<RedirectService>(
    () => RedirectServiceImpl(secureStorage: secureStorage),
  );

  // TODO(team): Add other services here as they are implemented
  // - AuthService
  // - Database
  // - SyncService
  // - etc.
}
