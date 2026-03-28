import 'package:nativus_pos_desktop/core/utils/helpers/auth_token_storage.dart';

abstract class AuthLocalDataSource {
  Future<void> saveAccessToken(String token);

  String? getAccessToken();

  Future<void> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final AuthTokenStorage _tokenStorage;

  const AuthLocalDataSourceImpl({required AuthTokenStorage tokenStorage})
    : _tokenStorage = tokenStorage;

  @override
  Future<void> saveAccessToken(String token) {
    return _tokenStorage.saveAccessToken(token);
  }

  @override
  String? getAccessToken() {
    return _tokenStorage.getAccessToken();
  }

  @override
  Future<void> clearSession() {
    return _tokenStorage.clear();
  }
}
