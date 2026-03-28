import 'package:nativus_pos_desktop/features/auth/domain/entities/example_entity.dart';
import 'package:nativus_pos_desktop/features/auth/domain/errors/example_failure.dart';
import 'package:nativus_pos_desktop/features/auth/domain/repositories/template_repository.dart';

class LoginUseCase {
	final AuthRepository _repository;

	const LoginUseCase({required AuthRepository repository})
		: _repository = repository;

	Future<AuthSessionEntity> call({
		required String email,
		required String pin,
	}) async {
		if (email.trim().isEmpty || pin.trim().isEmpty) {
			throw const AuthValidationFailure('Correo y PIN son obligatorios.');
		}

		return _repository.login(email: email.trim(), pin: pin.trim());
	}
}