import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nativus_pos_desktop/application/constants/products_api_endpoints.dart';
import 'package:nativus_pos_desktop/core/shared/data/models/paginated_response.dart';
import 'package:nativus_pos_desktop/core/utils/helpers/auth_token_storage.dart';
import 'package:nativus_pos_desktop/core/utils/helpers/http_helper.dart';
import 'package:nativus_pos_desktop/features/products/data/models/products_model.dart';

abstract class ProductsRemoteDataSource {
  Future<PaginatedResponse<ProductsModel>> getProducts({
    required int page,
    required int pageSize,
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
  Future<PaginatedResponse<ProductsModel>> getProducts({
    required int page,
    required int pageSize,
  }) async {
    try {
      final accessToken = _tokenStorage.getAccessToken();
      if (accessToken == null || accessToken.isEmpty) {
        throw StateError('Missing access token for products request.');
      }

      final uri = ProductsApiEndpoints.getProducts(
        page: page,
        items: pageSize,
      );

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
}
