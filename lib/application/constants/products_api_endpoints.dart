import 'package:nativus_pos_desktop/core/utils/helpers/api_helper.dart';

class ProductsApiEndpoints {
  static String get baseUrl => ApiHelper.baseUrl;

  // ** Get Products **
  static Uri getProducts({
    int? page,
    int? pageSize
  }) {

    final uri = Uri.parse('$baseUrl/products');
    final finalUri = uri.replace(
      queryParameters: {
        if (page != null) 'page': page.toString(),
        if (pageSize != null) 'page_size': pageSize.toString(),
      },
    );
    return finalUri;
  }
}