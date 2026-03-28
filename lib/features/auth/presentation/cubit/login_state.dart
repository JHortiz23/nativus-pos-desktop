import 'package:nativus_pos_desktop/features/auth/domain/entities/auth_entity.dart';

sealed class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final AuthSessionEntity session;

  const LoginSuccess(this.session);
}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure(this.message);
}
