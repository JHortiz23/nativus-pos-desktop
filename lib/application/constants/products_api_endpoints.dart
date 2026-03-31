import 'package:nativus_pos_desktop/core/utils/helpers/api_helper.dart';

class ProductsApiEndpoints {
  static String get baseUrl => ApiHelper.baseUrl;

  // ** Get Products **
  static Uri getProducts({int? page, int? items}) {
    final uri = Uri.parse('$baseUrl/products');
    final finalUri = uri.replace(
      queryParameters: {
        if (page != null) 'page': page.toString(),
        if (items != null) 'items': items.toString(),
      },
    );
    return finalUri;
  }

  // ** Get Product Categories **
  static Uri getProductCategories() {
    return Uri.parse('$baseUrl/products/categories');
  }
}
