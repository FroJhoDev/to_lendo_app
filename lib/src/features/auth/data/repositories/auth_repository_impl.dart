import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:to_lendo_app/src/features/auth/data/models/user_model.dart';
import 'package:to_lendo_app/src/features/auth/data/repositories/exceptions/auth_exception.dart' as app_auth;
import 'package:to_lendo_app/src/features/auth/domain/repositories/auth_repository.dart';

/// {@template auth_repository_impl}
/// Implementation of [AuthRepository] using [AuthRemoteDatasource].
/// {@endtemplate}
class AuthRepositoryImpl implements AuthRepository {
  /// {@macro auth_repository_impl}
  AuthRepositoryImpl({required this.remoteDatasource});

  /// Remote datasource for authentication operations.
  final AuthRemoteDatasource remoteDatasource;

  @override
  Future<Either<app_auth.AuthException, UserModel>> signInWithEmail({
    required String email,
    required String password,
  }) async => remoteDatasource.signInWithEmail(email: email, password: password);

  @override
  Future<Either<app_auth.AuthException, UserModel>> signUpWithEmail({
    required String email,
    required String password,
    String? name,
  }) async => remoteDatasource.signUpWithEmail(email: email, password: password, name: name);

  @override
  Future<Either<app_auth.AuthException, void>> resetPassword({required String email}) async =>
      remoteDatasource.resetPassword(email: email);

  @override
  Future<Either<app_auth.AuthException, void>> signOut() async => remoteDatasource.signOut();

  @override
  Future<Either<app_auth.AuthException, UserModel?>> getCurrentUser() async => remoteDatasource.getCurrentUser();
}
