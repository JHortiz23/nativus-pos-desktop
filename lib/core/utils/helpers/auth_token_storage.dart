import 'package:shared_preferences/shared_preferences.dart';

class AuthTokenStorage {
  static const _accessTokenKey = 'auth_access_token';

  final SharedPreferences _preferences;

  const AuthTokenStorage({required SharedPreferences preferences})
    : _preferences = preferences;

  Future<void> saveAccessToken(String token) async {
    await _preferences.setString(_accessTokenKey, token);
  }

  String? getAccessToken() {
    return _preferences.getString(_accessTokenKey);
  }

  Future<void> clear() async {
    await _preferences.remove(_accessTokenKey);
  }
}
