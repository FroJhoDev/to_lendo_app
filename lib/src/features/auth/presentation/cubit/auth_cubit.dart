import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template auth_cubit}
/// Cubit for managing authentication state.
/// {@endtemplate}
class AuthCubit extends Cubit<AuthState> {
  /// {@macro auth_cubit}
  AuthCubit({required AuthRepository authRepository}) : _authRepository = authRepository, super(const AuthState());

  final AuthRepository _authRepository;

  /// Checks if user is authenticated and updates state accordingly.
  Future<void> checkAuthStatus() async {
    emit(state.copyWith(status: AuthStateStatus.loading));

    final result = await _authRepository.getCurrentUser();

    result.fold(
      (error) => emit(state.copyWith(status: AuthStateStatus.unauthenticated, message: error.message)),
      (user) => user != null
          ? emit(state.copyWith(status: AuthStateStatus.authenticated, user: user))
          : emit(const AuthState(status: AuthStateStatus.unauthenticated)),
    );
  }

  /// Signs in a user with email and password.
  Future<void> signInWithEmail({required String email, required String password}) async {
    emit(state.copyWith(status: AuthStateStatus.loading, message: ''));

    final result = await _authRepository.signInWithEmail(email: email, password: password);

    result.fold(
      (error) => emit(state.copyWith(status: AuthStateStatus.error, message: error.message)),
      (user) => emit(state.copyWith(status: AuthStateStatus.authenticated, user: user)),
    );
  }

  /// Signs up a new user with email and password.
  Future<void> signUpWithEmail({required String email, required String password, String? name}) async {
    emit(state.copyWith(status: AuthStateStatus.loading, message: ''));

    final result = await _authRepository.signUpWithEmail(email: email, password: password, name: name);

    result.fold(
      (error) => emit(state.copyWith(status: AuthStateStatus.error, message: error.message)),
      (user) => emit(state.copyWith(status: AuthStateStatus.authenticated, user: user)),
    );
  }

  /// Resets password for the given email.
  Future<void> resetPassword({required String email}) async {
    emit(state.copyWith(status: AuthStateStatus.loading, message: ''));

    final result = await _authRepository.resetPassword(email: email);

    result.fold(
      (error) => emit(state.copyWith(status: AuthStateStatus.error, message: error.message)),
      (_) => emit(state.copyWith(status: AuthStateStatus.initial, message: 'Email de recuperação enviado com sucesso')),
    );
  }

  /// Signs out the current user.
  Future<void> signOut() async {
    emit(state.copyWith(status: AuthStateStatus.loading, message: ''));

    final result = await _authRepository.signOut();

    result.fold(
      (error) => emit(state.copyWith(status: AuthStateStatus.error, message: error.message)),
      (_) => emit(const AuthState(status: AuthStateStatus.unauthenticated)),
    );
  }
}
