// This is an example value object class --- IGNORE ---

class ExampleValidation {
  final String value;

  ExampleValidation._(this.value);

  /// Create a ExampleValidation or throw [FormatException] if invalid.
  factory ExampleValidation(String raw) {
    final normalized = raw;
    if (!ExampleValidation.isValid(normalized)) {
      throw const FormatException('Invalid password format');
    }
    return ExampleValidation._(normalized);
  }

  static bool isValid(String raw) {
    // Basic rule: at least 6 chars (common minimum for email/password flows).
    return raw.length >= 6;
  }

  @override
  String toString() => '***'; // Never expose raw values in logs

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExampleValidation && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;
}