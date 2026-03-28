import 'package:nativus_pos_desktop/core/utils/helpers/auth_token_storage.dart';

class HttpHelper {
	static Map<String, String> jsonHeaders({String? accessToken}) {
		return {
			if (accessToken != null && accessToken.isNotEmpty)
				'Authorization': 'Bearer $accessToken',
			'Content-Type': 'application/json',
		};
	}

	static Map<String, String> formUrlEncodedHeaders({String? accessToken}) {
		return {
			if (accessToken != null && accessToken.isNotEmpty)
				'Authorization': 'Bearer $accessToken',
			'Content-Type': 'application/x-www-form-urlencoded',
		};
	}

	static Map<String, String> multipartHeaders({String? accessToken}) {
		return {
			if (accessToken != null && accessToken.isNotEmpty)
				'Authorization': 'Bearer $accessToken',
			'Content-Type': 'multipart/form-data',
		};
	}

	static Map<String, String> jsonHeadersFromStorage(AuthTokenStorage storage) {
		return jsonHeaders(accessToken: storage.getAccessToken());
	}

	static Future<bool> clearSessionIfUnauthorized({
		required int statusCode,
		required AuthTokenStorage storage,
	}) async {
		if (statusCode == 401) {
			await storage.clear();
			return true;
		}
		return false;
	}
}