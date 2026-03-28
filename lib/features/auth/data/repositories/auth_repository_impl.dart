import 'package:nativus_pos_desktop/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:nativus_pos_desktop/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:nativus_pos_desktop/features/auth/domain/entities/example_entity.dart';
import 'package:nativus_pos_desktop/features/auth/domain/repositories/template_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  const AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<AuthSessionEntity> login({
    required String email,
    required String pin,
  }) async {
    final response = await _remoteDataSource.login(
      email: email,
      pin: pin,
    );

    await _localDataSource.saveAccessToken(response.accessToken);

    return response.toEntity();
  }

  @override
  Future<String?> getAccessToken() async {
    return _localDataSource.getAccessToken();
  }

  @override
  Future<void> logout() async {
    await _localDataSource.clearSession();
  }
}
