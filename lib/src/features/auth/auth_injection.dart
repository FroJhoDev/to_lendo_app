import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:to_lendo_app/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:to_lendo_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:to_lendo_app/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:to_lendo_app/src/injections.dart';

/// Initializes dependency injection for the auth feature.
Future<void> initAuthInjection() async {
  // Datasources
  injection
    ..registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasource(supabaseClient: injection<SupabaseClient>()),
    )
    // Repository
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDatasource: injection<AuthRemoteDatasource>()),
    )
    // Cubit
    ..registerFactory<AuthCubit>(() => AuthCubit(authRepository: injection<AuthRepository>()));
}
