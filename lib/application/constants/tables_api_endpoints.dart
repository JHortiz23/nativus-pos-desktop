import 'package:nativus_pos_desktop/core/utils/helpers/api_helper.dart';

class TablesApiEndpoints {
  static String get baseUrl => ApiHelper.baseUrl;

  // ** Get Dining Areas **
  static Uri getDiningAreas() {
    return Uri.parse('$baseUrl/tables/diningareas');
  }

  // ** Add Table **
  static Uri addTable() {
    return Uri.parse('$baseUrl/tables');
  }

  // ** Update Table **
  static Uri updateTable({required int id}) {
    return Uri.parse('$baseUrl/tables/$id');
  }

  // ** Delete Table **
  static Uri deleteTable({required int id}) {
    return Uri.parse('$baseUrl/tables/$id');
  }
}
