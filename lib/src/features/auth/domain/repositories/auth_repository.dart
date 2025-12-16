import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template auth_repository}
/// Interface for authentication repository operations.
/// {@endtemplate}
abstract interface class AuthRepository {
  /// Signs in a user with email and password.
  ///
  /// Returns [Right] with [UserModel] on success, or [Left] with [AuthException] on failure.
  Future<Either<AuthException, UserModel>> signInWithEmail({required String email, required String password});

  /// Signs up a new user with email and password.
  ///
  /// Returns [Right] with [UserModel] on success, or [Left] with [AuthException] on failure.
  Future<Either<AuthException, UserModel>> signUpWithEmail({
    required String email,
    required String password,
    String? name,
  });

  /// Resets password for the given email.
  ///
  /// Returns [Right] with void on success, or [Left] with [AuthException] on failure.
  Future<Either<AuthException, void>> resetPassword({required String email});

  /// Signs out the current user.
  ///
  /// Returns [Right] with void on success, or [Left] with [AuthException] on failure.
  Future<Either<AuthException, void>> signOut();

  /// Gets the current authenticated user.
  ///
  /// Returns [Right] with [UserModel] if authenticated, or [Left] with [AuthException] if not.
  Future<Either<AuthException, UserModel?>> getCurrentUser();
}
