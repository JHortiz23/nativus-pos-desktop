import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nativus_pos_desktop/application/constants/auth_api_endpoints.dart';
import 'package:nativus_pos_desktop/core/network/api_error_payload.dart';
import 'package:nativus_pos_desktop/core/utils/helpers/http_helper.dart';
import 'package:nativus_pos_desktop/features/auth/data/models/auth_login_models.dart';
import 'package:nativus_pos_desktop/features/auth/domain/errors/auth_failure.dart';

abstract class AuthRemoteDataSource {
  Future<AuthLoginResponseModel> login({
    required String email,
    required String pin,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client _client;

  const AuthRemoteDataSourceImpl({required http.Client client})
    : _client = client;

  @override
  Future<AuthLoginResponseModel> login({
    required String email,
    required String pin,
  }) async {
    try {
      final request = AuthLoginRequestModel(
        email: email,
        pin: pin,
      );

      final response = await _client.post(
        AuthApiEndpoints.login(),
        headers: HttpHelper.jsonHeaders(),
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        final payload = ApiErrorPayload.from(
          statusCode: response.statusCode,
          body: response.body,
        );

        final message = _extractErrorMessage(payload);
        if (response.statusCode == 401) {
          throw AuthUnauthorizedFailure(message);
        }
        throw AuthApiFailure(message, statusCode: response.statusCode);
      }

      final decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) {
        throw const AuthApiFailure('Response is not a valid JSON object.');
      }

      final authResponse = AuthLoginResponseModel.fromJson(decoded);
      if (authResponse.accessToken.isEmpty) {
        throw const AuthApiFailure('The server did not return an access token.');
      }

      return authResponse;
    } on SocketException {
      throw const AuthNetworkFailure();
    } on AuthFailure {
      rethrow;
    } catch (_) {
      throw const AuthUnknownFailure();
    }
  }

  String _extractErrorMessage(ApiErrorPayload payload) {
    final dynamic detailJson = payload.json?['detail'];
    final dynamic messageJson = payload.json?['message'];

    if (detailJson is String && detailJson.trim().isNotEmpty) {
      return detailJson;
    }
    if (messageJson is String && messageJson.trim().isNotEmpty) {
      return messageJson;
    }
    if (payload.detail != null && payload.detail!.trim().isNotEmpty) {
      return payload.detail!;
    }

    return 'Authentication error (HTTP ${payload.statusCode}).';
  }
}
