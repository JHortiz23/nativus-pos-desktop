sealed class AppFailure implements Exception {
  const AppFailure();
}

class ProductDuplicateFailure extends AppFailure {
  final String message;
  final int productId;
  const ProductDuplicateFailure(this.message, this.productId);
}

class ValidationFailure extends AppFailure {
  final String message;
  const ValidationFailure(this.message);
}

class NetworkFailure extends AppFailure {
  final String message;
  const NetworkFailure(this.message);
}

class ServerFailure extends AppFailure {
  final String message;
  const ServerFailure(this.message);
}

class UnknownFailure extends AppFailure {
  final String message;
  const UnknownFailure(this.message);
}
