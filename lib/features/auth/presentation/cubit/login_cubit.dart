import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nativus_pos_desktop/features/auth/domain/errors/auth_failure.dart';
import 'package:nativus_pos_desktop/features/auth/domain/use_cases/login_use_case.dart';
import 'package:nativus_pos_desktop/features/auth/presentation/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit({required LoginUseCase loginUseCase})
    : _loginUseCase = loginUseCase,
      super(const LoginInitial());

  Future<void> login({
    required String email,
    required String pin,
  }) async {
    if (state is LoginLoading) {
      return;
    }

    emit(const LoginLoading());

    try {
      final session = await _loginUseCase(
        email: email,
        pin: pin,
      );
      emit(LoginSuccess(session));
    } on AuthFailure catch (e) {
      emit(LoginFailure(e.message));
    } catch (_) {
      emit(const LoginFailure('An unexpected error occurred. Please try again.'));
    }
  }
}
