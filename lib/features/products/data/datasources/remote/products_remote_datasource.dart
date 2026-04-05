import 'dart:convert';
import 'package:http/http.dart' as http;
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
  Future<PaginatedResponse<ProductsModel>> getProducts({
    required int page,
    required int pageSize,
  });

  Future<List<ProductCategoriesModel>> getProductCategories();

  Future<ProductsModel> updateProduct({
    required int id,
    required int categoryId,
    required String name,
    required String description,
    required double price,
    required bool isActive,
  });
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final http.Client _client;
  final AuthTokenStorage _tokenStorage;

  ProductsRemoteDataSourceImpl({
    required http.Client client,
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
      final body = json.encode({
        'name': name,
        'price': price,
        'categoryId': categoryId,
        'description': description,
        'isActive': isActive,
      });

      final response = await _client.post(uri, headers: headers, body: body);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        await HttpHelper.clearSessionIfUnauthorized(
          statusCode: response.statusCode,
          storage: _tokenStorage,
        );
        throw Exception('Failed to add product: HTTP ${response.statusCode}');
      }

      final decoded = json.decode(response.body);

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
  Future<PaginatedResponse<ProductsModel>> getProducts({
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
      final response = await _client.get(uri, headers: headers);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        await HttpHelper.clearSessionIfUnauthorized(
          statusCode: response.statusCode,
          storage: _tokenStorage,
        );
        throw Exception('Failed to load products: HTTP ${response.statusCode}');
      }

      final decoded = json.decode(response.body);

      if (decoded is! Map<String, dynamic>) {
        throw const FormatException(
          'Unexpected products payload. Expected a JSON object.',
        );
      }
      return PaginatedResponse<ProductsModel>.fromJson(
        decoded,
        (json) => ProductsModel.fromJson(json),
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
      final response = await _client.get(uri, headers: headers);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        await HttpHelper.clearSessionIfUnauthorized(
          statusCode: response.statusCode,
          storage: _tokenStorage,
        );
        throw Exception(
          'Failed to load product categories: HTTP ${response.statusCode}',
        );
      }

      final decoded = json.decode(response.body);

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
  Future<ProductsModel> updateProduct({
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
      final body = json.encode({
        'name': name,
        'price': price,
        'categoryId': categoryId,
        'description': description,
        'isActive': isActive,
      });

      final response = await _client.put(uri, headers: headers, body: body);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        await HttpHelper.clearSessionIfUnauthorized(
          statusCode: response.statusCode,
          storage: _tokenStorage,
        );
        throw Exception(
          'Failed to update product: HTTP ${response.statusCode}',
        );
      }

      final decoded = json.decode(response.body);

      if (decoded is! Map<String, dynamic>) {
        throw const FormatException(
          'Unexpected update product response. Expected a JSON object.',
        );
      }

      return ProductsModel.fromJson(decoded);
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }
}
