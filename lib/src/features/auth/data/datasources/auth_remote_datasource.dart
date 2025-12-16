import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template auth_remote_datasource}
/// Remote datasource for authentication operations using Supabase.
/// {@endtemplate}
class AuthRemoteDatasource {
  /// {@macro auth_remote_datasource}
  AuthRemoteDatasource({required this.supabaseClient});

  /// Supabase client instance for authentication operations.
  final SupabaseClient supabaseClient;

  /// Signs in a user with email and password.
  Future<Either<AuthException, UserModel>> signInWithEmail({required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(email: email, password: password);

      if (response.user != null) {
        final user = UserModel.fromSupabaseUser(response.user!);
        return Right(user);
      }

      return const Left(AuthException('Falha no login'));
    } catch (error) {
      return Left(_mapSupabaseError(error));
    }
  }

  /// Signs up a new user with email and password.
  Future<Either<AuthException, UserModel>> signUpWithEmail({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: name != null ? {'name': name} : null,
      );

      if (response.user != null) {
        final user = UserModel.fromSupabaseUser(response.user!);
        return Right(user);
      }

      return const Left(AuthException('Falha no registro'));
    } catch (error) {
      return Left(_mapSupabaseError(error));
    }
  }

  /// Resets password for the given email.
  Future<Either<AuthException, void>> resetPassword({required String email}) async {
    try {
      await supabaseClient.auth.resetPasswordForEmail(email);
      return const Right(null);
    } catch (error) {
      return Left(_mapSupabaseError(error));
    }
  }

  /// Signs out the current user.
  Future<Either<AuthException, void>> signOut() async {
    try {
      await supabaseClient.auth.signOut();
      return const Right(null);
    } catch (error) {
      return Left(_mapSupabaseError(error));
    }
  }

  /// Gets the current authenticated user.
  Future<Either<AuthException, UserModel?>> getCurrentUser() async {
    try {
      final session = supabaseClient.auth.currentSession;
      if (session?.user != null) {
        final user = UserModel.fromSupabaseUser(session!.user);
        return Right(user);
      }
      return const Right(null);
    } catch (error) {
      return Left(_mapSupabaseError(error));
    }
  }

  /// Maps Supabase errors to user-friendly messages.
  AuthException _mapSupabaseError(dynamic error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('invalid login credentials') || errorString.contains('invalid credentials')) {
      return const AuthException('Email ou senha incorretos');
    }

    if (errorString.contains('email not confirmed') || errorString.contains('email not verified')) {
      return const AuthException('Por favor, confirme seu email antes de fazer login');
    }

    if (errorString.contains('too many requests') || errorString.contains('rate limit')) {
      return const AuthException('Muitas tentativas. Por favor, tente novamente mais tarde');
    }

    if (errorString.contains('user already registered') || errorString.contains('email already exists')) {
      return const AuthException('Este email já está cadastrado');
    }

    if (errorString.contains('password')) {
      return const AuthException('A senha deve ter pelo menos 6 caracteres');
    }

    if (errorString.contains('email')) {
      return const AuthException('Por favor, insira um email válido');
    }

    return AuthException('Erro ao realizar operação: $error');
  }
}
