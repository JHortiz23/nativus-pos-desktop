import 'package:dio/dio.dart';
import 'package:nativus_pos_desktop/application/constants/tables_api_endpoints.dart';
import 'package:nativus_pos_desktop/core/utils/helpers/auth_token_storage.dart';
import 'package:nativus_pos_desktop/core/utils/helpers/http_helper.dart';
import 'package:nativus_pos_desktop/features/tables/data/models/dining_areas_response_model.dart';
import 'package:nativus_pos_desktop/features/tables/data/models/table_model.dart';

abstract class TablesRemoteDataSource {
  Future<TableModel> addTable({
    required String name,
    required int seats,
    required int diningAreaId,
    required bool isActive,
  });
  Future<DiningAreasResponseModel> getDiningAreas();

  Future<TableModel> updateTable({
    required int id,
    required String name,
    required int seats,
    required int diningAreaId,
    required bool isActive,
  });

  Future<TableModel> deleteTable({required int id});
}

class TablesRemoteDataSourceImpl implements TablesRemoteDataSource {
  final Dio _client;
  final AuthTokenStorage _tokenStorage;

  TablesRemoteDataSourceImpl({
    required Dio client,
    required AuthTokenStorage tokenStorage,
  }) : _client = client,
       _tokenStorage = tokenStorage;

  @override
  Future<TableModel> addTable({
    required String name,
    required int seats,
    required int diningAreaId,
    required bool isActive,
  }) async {
    try {
      final accessToken = _tokenStorage.getAccessToken();
      if (accessToken == null || accessToken.isEmpty) {
        throw StateError('Missing access token for add table request.');
      }

      final uri = TablesApiEndpoints.addTable();

      final headers = HttpHelper.jsonHeaders(accessToken: accessToken);
      final body = {
        'name': name,
        'seats': seats,
        'diningAreaId': diningAreaId,
        'isActive': isActive,
      };

      final response = await _client.post(
        uri.toString(),
        options: Options(headers: headers, validateStatus: (status) => true),
        data: body,
      );

      if ((response.statusCode ?? 500) < 200 ||
          (response.statusCode ?? 500) >= 300) {
        await HttpHelper.clearSessionIfUnauthorized(
          statusCode: response.statusCode ?? 500,
          storage: _tokenStorage,
        );
        throw Exception('Failed to add table: HTTP ${response.statusCode}');
      }

      final decoded = response.data;

      if (decoded is! Map<String, dynamic>) {
        throw const FormatException(
          'Unexpected add table response. Expected a JSON object.',
        );
      }

      return TableModel.fromJson(decoded);
    } catch (e) {
      throw Exception('Error adding table: $e');
    }
  }

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
          validateStatus: (status) =>
              true, // Conservamos la validación manual antigua
        ),
      );

      if ((response.statusCode ?? 500) < 200 ||
          (response.statusCode ?? 500) >= 300) {
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

  @override
  Future<TableModel> updateTable({
    required int id,
    required String name,
    required int seats,
    required int diningAreaId,
    required bool isActive,
  }) async {
    try {
      final accessToken = _tokenStorage.getAccessToken();
      if (accessToken == null || accessToken.isEmpty) {
        throw StateError('Missing access token for update table request.');
      }

      final uri = TablesApiEndpoints.updateTable(id: id);

      final headers = HttpHelper.jsonHeaders(accessToken: accessToken);
      final body = {
        'name': name,
        'seats': seats,
        'diningAreaId': diningAreaId,
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
          'Failed to update table: HTTP ${response.statusCode}',
        );
      }

      final decoded = response.data;

      if (decoded is! Map<String, dynamic>) {
        throw const FormatException(
          'Unexpected update table response. Expected a JSON object.',
        );
      }

      return TableModel.fromJson(decoded);
    } catch (e) {
      throw Exception('Error updating table: $e');
    }
  }

  @override
  Future<TableModel> deleteTable({required int id}) async {
    try {
      final accessToken = _tokenStorage.getAccessToken();
      if (accessToken == null || accessToken.isEmpty) {
        throw StateError('Missing access token for delete table request.');
      }

      final uri = TablesApiEndpoints.deleteTable(id: id);

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
          'Failed to delete table: HTTP ${response.statusCode}',
        );
      }

      final decoded = response.data;

      if (decoded is! Map<String, dynamic>) {
        throw const FormatException(
          'Unexpected delete table response. Expected a JSON object.',
        );
      }

      return TableModel.fromJson(decoded);
    } catch (e) {
      throw Exception('Error deleting table: $e');
    }
  }


}
