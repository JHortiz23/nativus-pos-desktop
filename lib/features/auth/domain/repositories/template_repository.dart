import 'package:nativus_pos_desktop/features/auth/domain/entities/example_entity.dart';

abstract class AuthRepository {
	Future<AuthSessionEntity> login({
		required String email,
		required String pin,
	});

	Future<void> logout();

	Future<String?> getAccessToken();
}