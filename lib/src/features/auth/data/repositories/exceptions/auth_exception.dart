/// {@template auth_exception}
/// Exception class for authentication-related errors.
/// {@endtemplate}
class AuthException implements Exception {
  /// {@macro auth_exception}
  const AuthException(this.message);

  /// Error message
  final String message;

  @override
  String toString() => 'AuthException: $message';
}
