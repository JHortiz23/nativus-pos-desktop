import 'package:nativus_pos_desktop/features/auth/domain/entities/auth_entity.dart';
import 'package:nativus_pos_desktop/features/auth/domain/errors/auth_failure.dart';
import 'package:nativus_pos_desktop/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
	final AuthRepository _repository;

	const LoginUseCase({required AuthRepository repository})
		: _repository = repository;

	Future<AuthSessionEntity> call({
		required String email,
		required String pin,
	}) async {
		if (email.trim().isEmpty || pin.trim().isEmpty) {
			throw const AuthValidationFailure('Email and PIN are required.');
		}

		return _repository.login(email: email.trim(), pin: pin.trim());
	}
}