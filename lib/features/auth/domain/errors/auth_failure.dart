sealed class AuthFailure implements Exception {
  final String message;
  final int? statusCode;

  const AuthFailure(this.message, {this.statusCode});

  @override
  String toString() => '$runtimeType: $message';
}

class AuthValidationFailure extends AuthFailure {
  const AuthValidationFailure([super.message = 'Datos de acceso invalidos.']);
}

class AuthNetworkFailure extends AuthFailure {
  const AuthNetworkFailure([super.message = 'No se pudo conectar al servidor.']);
}

class AuthUnauthorizedFailure extends AuthFailure {
  const AuthUnauthorizedFailure([
    super.message = 'Credenciales invalidas o sesion expirada.',
  ]) : super(statusCode: 401);
}

class AuthApiFailure extends AuthFailure {
  const AuthApiFailure(super.message, {super.statusCode});
}

class AuthUnknownFailure extends AuthFailure {
  const AuthUnknownFailure([super.message = 'Ocurrio un error inesperado.']);
}