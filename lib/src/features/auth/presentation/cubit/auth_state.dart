import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/src.dart';

part 'auth_state.freezed.dart';

/// {@template auth_state_status}
/// Status of the authentication state.
/// {@endtemplate}
enum AuthStateStatus {
  /// Initial state
  initial,

  /// Loading state
  loading,

  /// User is authenticated
  authenticated,

  /// User is not authenticated
  unauthenticated,

  /// Error state
  error,
}

/// {@template auth_state}
/// State for authentication management.
/// {@endtemplate}
@freezed
class AuthState with _$AuthState {
  /// {@macro auth_state}
  const factory AuthState({
    @Default(AuthStateStatus.initial) AuthStateStatus status,
    @Default('') String message,
    UserModel? user,
  }) = _AuthState;
}
