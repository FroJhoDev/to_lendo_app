import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/src.dart';

/// GetIt instance
final injection = GetIt.instance;

/// Initializes dependency injection for the application.
Future<void> initInjection() async {
  // Secure Storage instance
  const secureStorage = FlutterSecureStorage();

  // Supabase Client
  injection
    ..registerLazySingleton<SupabaseClient>(() => Supabase.instance.client)
    // Core Services
    ..registerLazySingleton<RedirectService>(() => RedirectServiceImpl(secureStorage: secureStorage));

  // Feature Injections
  await initAuthInjection();

  // TODO(team): Add other feature injections here as they are implemented
  // - Books
  // - Reading Sessions
  // - Statistics
  // - Profile
  // - Sync
}
