import 'package:nativus_pos_desktop/core/utils/helpers/api_helper.dart';

class TablesApiEndpoints {
  static String get baseUrl => ApiHelper.baseUrl;

  // ** Get Dining Areas **
  static Uri getDiningAreas() {
    return Uri.parse('$baseUrl/tables/diningareas');
  }

}
