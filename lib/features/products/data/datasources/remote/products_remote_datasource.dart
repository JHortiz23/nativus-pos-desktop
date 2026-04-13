import 'package:dio/dio.dart';
import 'package:nativus_pos_desktop/application/constants/products_api_endpoints.dart';
import 'package:nativus_pos_desktop/core/shared/data/models/paginated_response.dart';
import 'package:nativus_pos_desktop/core/utils/helpers/auth_token_storage.dart';
import 'package:nativus_pos_desktop/core/utils/helpers/http_helper.dart';
import 'package:nativus_pos_desktop/features/products/data/models/added_product_model.dart';
import 'package:nativus_pos_desktop/features/products/data/models/product_categories_model.dart';
import 'package:nativus_pos_desktop/features/products/data/models/products_model.dart';

abstract class ProductsRemoteDataSource {
  Future<AddedProductModel> addProduct({
    required int categoryId,
    required String name,
    required String description,
    required double price,
    required bool isActive,
  });
  Future<PaginatedResponse<ProductModel>> getProducts({
    required int page,
    required int pageSize,
  });

  Future<List<ProductCategoriesModel>> getProductCategories();

  Future<ProductModel> updateProduct({
    required int id,
    required int categoryId,
    required String name,
    required String description,
    required double price,
    required bool isActive,
  });

  Future<ProductModel> deleteProduct({required int id});
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final Dio _client;
  final AuthTokenStorage _tokenStorage;

  ProductsRemoteDataSourceImpl({
    required Dio client,
    required AuthTokenStorage tokenStorage,
  }) : _client = client,
       _tokenStorage = tokenStorage;

  @override
  Future<AddedProductModel> addProduct({
    required int categoryId,
    required String name,
    required String description,
    required double price,
    required bool isActive,
  }) async {
    try {
      final accessToken = _tokenStorage.getAccessToken();
      if (accessToken == null || accessToken.isEmpty) {
        throw StateError('Missing access token for add product request.');
      }

      final uri = ProductsApiEndpoints.addProduct();

      final headers = HttpHelper.jsonHeaders(accessToken: accessToken);
      final body = {
        'name': name,
        'price': price,
        'categoryId': categoryId,
        'description': description,
        'isActive': isActive,
      };

      final response = await _client.post(
        uri.toString(), 
        options: Options(
          headers: headers,
          validateStatus: (status) => true,
        ),
        data: body,
      );

      if ((response.statusCode ?? 500) < 200 || (response.statusCode ?? 500) >= 300) {
        await HttpHelper.clearSessionIfUnauthorized(
          statusCode: response.statusCode ?? 500,
          storage: _tokenStorage,
        );
        throw Exception('Failed to add product: HTTP ${response.statusCode}');
      }

      final decoded = response.data;

      if (decoded is! Map<String, dynamic>) {
        throw const FormatException(
          'Unexpected add product response. Expected a JSON object.',
        );
      }

      return AddedProductModel.fromJson(decoded);
    } catch (e) {
      throw Exception('Error adding product: $e');
    }
  }

  @override
  Future<PaginatedResponse<ProductModel>> getProducts({
    required int page,
    required int pageSize,
  }) async {
    try {
      final accessToken = _tokenStorage.getAccessToken();
      if (accessToken == null || accessToken.isEmpty) {
        throw StateError('Missing access token for products request.');
      }

      final uri = ProductsApiEndpoints.getProducts(page: page, items: pageSize);

      final headers = HttpHelper.jsonHeaders(accessToken: accessToken);
      
      final response = await _client.get(
        uri.toString(), 
        options: Options(
          headers: headers,
          validateStatus: (status) => true,
        ),
      );

      if ((response.statusCode ?? 500) < 200 || (response.statusCode ?? 500) >= 300) {
        await HttpHelper.clearSessionIfUnauthorized(
          statusCode: response.statusCode ?? 500,
          storage: _tokenStorage,
        );
        throw Exception('Failed to load products: HTTP ${response.statusCode}');
      }

      final decoded = response.data;

      if (decoded is! Map<String, dynamic>) {
        throw const FormatException(
          'Unexpected products payload. Expected a JSON object.',
        );
      }
      return PaginatedResponse<ProductModel>.fromJson(
        decoded,
        (json) => ProductModel.fromJson(json),
        itemsKey: 'products',
      );
    } catch (e) {
      throw Exception('Error getting products: $e');
    }
  }

  @override
  Future<List<ProductCategoriesModel>> getProductCategories() async {
    try {
      final accessToken = _tokenStorage.getAccessToken();
      if (accessToken == null || accessToken.isEmpty) {
        throw StateError('Missing access token for products request.');
      }

      final uri = ProductsApiEndpoints.getProductCategories();

      final headers = HttpHelper.jsonHeaders(accessToken: accessToken);
      
      final response = await _client.get(
        uri.toString(), 
        options: Options(
          headers: headers,
          validateStatus: (status) => true,
        ),
      );

      if ((response.statusCode ?? 500) < 200 || (response.statusCode ?? 500) >= 300) {
        await HttpHelper.clearSessionIfUnauthorized(
          statusCode: response.statusCode ?? 500,
          storage: _tokenStorage,
        );
        throw Exception(
          'Failed to load product categories: HTTP ${response.statusCode}',
        );
      }

      final decoded = response.data;

      if (decoded is! List) {
        throw const FormatException(
          'Unexpected product categories payload. Expected a JSON list.',
        );
      }

      final items = decoded;
      return items
          .map(
            (json) =>
                ProductCategoriesModel.fromJson(json as Map<String, dynamic>),
          )
          .toList(growable: false);
    } catch (e) {
      throw Exception('Error getting product categories: $e');
    }
  }

  @override
  Future<ProductModel> updateProduct({
    required int id,
    required int categoryId,
    required String name,
    required String description,
    required double price,
    required bool isActive,
  }) async {
    try {
      final accessToken = _tokenStorage.getAccessToken();
      if (accessToken == null || accessToken.isEmpty) {
        throw StateError('Missing access token for update product request.');
      }

      final uri = ProductsApiEndpoints.updateProduct(id: id);

      final headers = HttpHelper.jsonHeaders(accessToken: accessToken);
      final body = {
        'name': name,
        'price': price,
        'categoryId': categoryId,
        'description': description,
        'isActive': isActive,
      };

      final response = await _client.put(
        uri.toString(), 
        options: Options(
          headers: headers,
          validateStatus: (status) => true,
        ),
        data: body,
      );

      if ((response.statusCode ?? 500) < 200 || (response.statusCode ?? 500) >= 300) {
        await HttpHelper.clearSessionIfUnauthorized(
          statusCode: response.statusCode ?? 500,
          storage: _tokenStorage,
        );
        throw Exception(
          'Failed to update product: HTTP ${response.statusCode}',
        );
      }

      final decoded = response.data;

      if (decoded is! Map<String, dynamic>) {
        throw const FormatException(
          'Unexpected update product response. Expected a JSON object.',
        );
      }

      return ProductModel.fromJson(decoded);
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }

  @override
  Future<ProductModel> deleteProduct({required int id}) async {
    try {
      final accessToken = _tokenStorage.getAccessToken();
      if (accessToken == null || accessToken.isEmpty) {
        throw StateError('Missing access token for delete product request.');
      }

      final uri = ProductsApiEndpoints.deleteProduct(id: id);

      final headers = HttpHelper.jsonHeaders(accessToken: accessToken);
      
      final response = await _client.delete(
        uri.toString(), 
        options: Options(
          headers: headers,
          validateStatus: (status) => true,
        ),
      );

      if ((response.statusCode ?? 500) < 200 || (response.statusCode ?? 500) >= 300) {
        await HttpHelper.clearSessionIfUnauthorized(
          statusCode: response.statusCode ?? 500,
          storage: _tokenStorage,
        );
        throw Exception(
          'Failed to delete product: HTTP ${response.statusCode}',
        );
      }

      final decoded = response.data;

      if (decoded is! Map<String, dynamic>) {
        throw const FormatException(
          'Unexpected delete product response. Expected a JSON object.',
        );
      }

      return ProductModel.fromJson(decoded);
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }
}
