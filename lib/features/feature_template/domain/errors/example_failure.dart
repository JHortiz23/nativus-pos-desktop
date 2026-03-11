// This is an example failure class for validation errors structure.

sealed class ExampleFailure implements Exception {
  final String message;
  const ExampleFailure(this.message);

  @override
  String toString() => '$runtimeType: $message';
}

class ExampleValidationFailure extends ExampleFailure {
  const ExampleValidationFailure([super.message = 'this is an example validation failure']);
}