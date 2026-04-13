import 'package:dio/dio.dart';
import 'package:nativus_pos_desktop/application/constants/tables_api_endpoints.dart';
import 'package:nativus_pos_desktop/core/utils/helpers/auth_token_storage.dart';
import 'package:nativus_pos_desktop/core/utils/helpers/http_helper.dart';
import 'package:nativus_pos_desktop/features/tables/data/models/dining_areas_response_model.dart';

abstract class TablesRemoteDataSource {
  // Future<AddedProductModel> addProduct({
  //   required int categoryId,
  //   required String name,
  //   required String description,
  //   required double price,
  //   required bool isActive,
  // });
  Future<DiningAreasResponseModel> getDiningAreas();

  // Future<List<ProductCategoriesModel>> getProductCategories();

  // Future<ProductModel> updateProduct({
  //   required int id,
  //   required int categoryId,
  //   required String name,
  //   required String description,
  //   required double price,
  //   required bool isActive,
  // });

  // Future<ProductModel> deleteProduct({required int id});
}

class TablesRemoteDataSourceImpl implements TablesRemoteDataSource {
  final Dio _client;
  final AuthTokenStorage _tokenStorage;

  TablesRemoteDataSourceImpl({
    required Dio client,
    required AuthTokenStorage tokenStorage,
  }) : _client = client,
       _tokenStorage = tokenStorage;

  // @override
  // Future<AddedProductModel> addProduct({
  //   required int categoryId,
  //   required String name,
  //   required String description,
  //   required double price,
  //   required bool isActive,
  // }) async {
  //   try {
  //     final accessToken = _tokenStorage.getAccessToken();
  //     if (accessToken == null || accessToken.isEmpty) {
  //       throw StateError('Missing access token for add product request.');
  //     }

  //     final uri = ProductsApiEndpoints.addProduct();

  //     final headers = HttpHelper.jsonHeaders(accessToken: accessToken);
  //     final body = json.encode({
  //       'name': name,
  //       'price': price,
  //       'categoryId': categoryId,
  //       'description': description,
  //       'isActive': isActive,
  //     });

  //     final response = await _client.post(uri, headers: headers, body: body);

  //     if (response.statusCode < 200 || response.statusCode >= 300) {
  //       await HttpHelper.clearSessionIfUnauthorized(
  //         statusCode: response.statusCode,
  //         storage: _tokenStorage,
  //       );
  //       throw Exception('Failed to add product: HTTP ${response.statusCode}');
  //     }

  //     final decoded = json.decode(response.body);

  //     if (decoded is! Map<String, dynamic>) {
  //       throw const FormatException(
  //         'Unexpected add product response. Expected a JSON object.',
  //       );
  //     }

  //     return AddedProductModel.fromJson(decoded);
  //   } catch (e) {
  //     throw Exception('Error adding product: $e');
  //   }
  // }

  // @override
  // Future<List<DiningAreaModel>> getDiningAreas({
  //   required int page,
  //   required int pageSize,
  // }) async {
  //   try {
  //     final accessToken = _tokenStorage.getAccessToken();
  //     if (accessToken == null || accessToken.isEmpty) {
  //       throw StateError('Missing access token for products request.');
  //     }

  //     final uri = ProductsApiEndpoints.getProducts(page: page, items: pageSize);

  //     final headers = HttpHelper.jsonHeaders(accessToken: accessToken);
  //     final response = await _client.get(uri, headers: headers);

  //     if (response.statusCode < 200 || response.statusCode >= 300) {
  //       await HttpHelper.clearSessionIfUnauthorized(
  //         statusCode: response.statusCode,
  //         storage: _tokenStorage,
  //       );
  //       throw Exception('Failed to load products: HTTP ${response.statusCode}');
  //     }

  //     final decoded = json.decode(response.body);

  //     if (decoded is! Map<String, dynamic>) {
  //       throw const FormatException(
  //         'Unexpected products payload. Expected a JSON object.',
  //       );
  //     }
  //     return PaginatedResponse<DiningAreaModel>.fromJson(
  //       decoded,
  //       (json) => DiningAreaModel.fromJson(json),
  //       itemsKey: 'diningAreas',
  //     ).items;
  //   } catch (e) {
  //     throw Exception('Error getting products: $e');
  //   }
  // }

  @override
  Future<DiningAreasResponseModel> getDiningAreas() async {
    try {
      final accessToken = _tokenStorage.getAccessToken();
      if (accessToken == null || accessToken.isEmpty) {
        throw StateError('Missing access token for dining areas request.');
      }

      final uri = TablesApiEndpoints.getDiningAreas();

      final headers = HttpHelper.jsonHeaders(accessToken: accessToken);
      
      final response = await _client.get(
        uri.toString(), 
        options: Options(
          headers: headers,
          validateStatus: (status) => true, // Conservamos la validación manual antigua
        ),
      );

      if ((response.statusCode ?? 500) < 200 || (response.statusCode ?? 500) >= 300) {
        await HttpHelper.clearSessionIfUnauthorized(
          statusCode: response.statusCode ?? 500,
          storage: _tokenStorage,
        );
        throw Exception(
          'Failed to load tables response: HTTP ${response.statusCode}',
        );
      }

      // Dio auto-decodes JSON payloads:
      final decoded = response.data;

      if (decoded is! Map<String, dynamic>) {
        throw const FormatException(
          'Unexpected tables response payload. Expected a JSON object.',
        );
      }

      return DiningAreasResponseModel.fromJson(decoded);
    } catch (e) {
      throw Exception('Error getting dining areas: $e');
    }
  }

  // @override
  // Future<ProductModel> updateProduct({
  //   required int id,
  //   required int categoryId,
  //   required String name,
  //   required String description,
  //   required double price,
  //   required bool isActive,
  // }) async {
  //   try {
  //     final accessToken = _tokenStorage.getAccessToken();
  //     if (accessToken == null || accessToken.isEmpty) {
  //       throw StateError('Missing access token for update product request.');
  //     }

  //     final uri = ProductsApiEndpoints.updateProduct(id: id);

  //     final headers = HttpHelper.jsonHeaders(accessToken: accessToken);
  //     final body = json.encode({
  //       'name': name,
  //       'price': price,
  //       'categoryId': categoryId,
  //       'description': description,
  //       'isActive': isActive,
  //     });

  //     final response = await _client.put(uri, headers: headers, body: body);

  //     if (response.statusCode < 200 || response.statusCode >= 300) {
  //       await HttpHelper.clearSessionIfUnauthorized(
  //         statusCode: response.statusCode,
  //         storage: _tokenStorage,
  //       );
  //       throw Exception(
  //         'Failed to update product: HTTP ${response.statusCode}',
  //       );
  //     }

  //     final decoded = json.decode(response.body);

  //     if (decoded is! Map<String, dynamic>) {
  //       throw const FormatException(
  //         'Unexpected update product response. Expected a JSON object.',
  //       );
  //     }

  //     return ProductModel.fromJson(decoded);
  //   } catch (e) {
  //     throw Exception('Error updating product: $e');
  //   }
  // }

  // @override
  // Future<ProductModel> deleteProduct({required int id}) async {
  //   try {
  //     final accessToken = _tokenStorage.getAccessToken();
  //     if (accessToken == null || accessToken.isEmpty) {
  //       throw StateError('Missing access token for delete product request.');
  //     }

  //     final uri = ProductsApiEndpoints.deleteProduct(id: id);

  //     final headers = HttpHelper.jsonHeaders(accessToken: accessToken);
  //     final response = await _client.delete(uri, headers: headers);

  //     if (response.statusCode < 200 || response.statusCode >= 300) {
  //       await HttpHelper.clearSessionIfUnauthorized(
  //         statusCode: response.statusCode,
  //         storage: _tokenStorage,
  //       );
  //       throw Exception(
  //         'Failed to delete product: HTTP ${response.statusCode}',
  //       );
  //     }

  //     final decoded = json.decode(response.body);

  //     if (decoded is! Map<String, dynamic>) {
  //       throw const FormatException(
  //         'Unexpected delete product response. Expected a JSON object.',
  //       );
  //     }

  //     return ProductModel.fromJson(decoded);
  //   } catch (e) {
  //     throw Exception('Error deleting product: $e');
  //   }
  // }
}
