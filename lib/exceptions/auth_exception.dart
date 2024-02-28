class AuthException implements Exception {
  final String key;

  static const Map<String, String> erros = {
    'EMAIL_EXISTS': "The email provided is already registered.",
    'OPERATION_NOT_ALLOWED': "The operation cannot be performed at the moment.",
    'TOO_MANY_ATTEMPTS_TRY_LATER': "Please try again later.",
    'EMAIL_NOT_FOUND': "Invalid email or password.",
    'INVALID_PASSWORD': "Invalid email or password.",
    "INVALID_LOGIN_CREDENTIALS": "Invalid email or password.",
    'USER_DISABLED': "The user account has been deactivated.",
  };

  AuthException({required this.key});

  @override
  String toString() {
    return erros[key] ?? 'There was an authentication error.';
  }
}
