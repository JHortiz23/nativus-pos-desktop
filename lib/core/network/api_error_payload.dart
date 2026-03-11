import 'dart:convert';

class ApiErrorPayload {
  final int statusCode;
  final String? detail;
  final Map<String, dynamic>? json;
  final dynamic prop;

  const ApiErrorPayload({
    required this.statusCode,
    this.detail,
    this.json,
    this.prop
  });

  factory ApiErrorPayload.from({
    required int statusCode,
    Object? body,
    String? propName,
  }) {
    if (body is Map<String, dynamic>) {
      final d = body['detail'];
      return ApiErrorPayload(
        statusCode: statusCode,
        detail: d is String ? d : null,
        json: body,
        prop: propName != null && d is Map<String, dynamic> ? d[propName] : null,
      );
    }

    if (body is String) {
      try {
        final decoded = jsonDecode(body);
        if (decoded is Map<String, dynamic>) {
          final d = decoded['detail'];
          return ApiErrorPayload(
            statusCode: statusCode,
            detail: d is String ? d : null,
            json: decoded,
            prop: propName != null && d is Map<String, dynamic> ? d[propName] : null,
          );
        }
      } catch (_) {}

      return ApiErrorPayload(statusCode: statusCode, detail: body);
    }

    return ApiErrorPayload(statusCode: statusCode);
  }
}
