class JsonParsingHelper {
  static int asInt(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }

  static double asDouble(dynamic value) {
    if (value is double) {
      return value;
    }
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    if (value is int) {
      return value.toDouble();
    }
    return 0.0;
  }

  static String asString(dynamic value) {
    if (value == null) {
      return '';
    }
    return value.toString();
  }

  static bool asBool(dynamic value) {
    if (value is bool) {
      return value;
    }
    if (value is String) {
      return value.toLowerCase() == 'true';
    }
    if (value is num) {
      return value != 0;
    }
    return false;
  }

  static Map<String, dynamic> asMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    }
    return {};
  }
}
