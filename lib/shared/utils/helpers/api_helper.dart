import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiHelper {
  static String? _baseUrl;

  static String get baseUrl {
    _baseUrl ??= dotenv.env['API_BASE_URL'];
    return _baseUrl!;
  }
}
