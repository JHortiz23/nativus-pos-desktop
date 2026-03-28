
import 'package:nativus_pos_desktop/core/utils/helpers/api_helper.dart';

class AuthApiEndpoints {
  static String get baseUrl => ApiHelper.baseUrl;

  // ** Login endpoint **
  static Uri login() {
    return Uri.parse('$baseUrl/auth/login');
  }
}
