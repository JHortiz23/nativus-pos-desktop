import 'package:nativus_pos_desktop/core/utils/helpers/api_helper.dart';

class ProductsApiEndpoints {
  static String get baseUrl => ApiHelper.baseUrl;

  // ** Add Product **
  static Uri addProduct() {
    return Uri.parse('$baseUrl/products');
  }

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

  // ** Update Product **
  static Uri updateProduct({required int id}) {
    return Uri.parse('$baseUrl/products/$id');
  }

  // ** Delete Product **
  static Uri deleteProduct({required int id}) {
    return Uri.parse('$baseUrl/products/$id');
  }
}
