part of 'products_bloc.dart';

class ProductsState extends Equatable {
  final PaginatedResponse<ProductsEntity>? products;
  final List<ProductCategoriesEntity>? productCategories;
  final RequestsEnum getProductsRequest;
  final bool isLoading;
  final String errorMessage;
  final int page;
  final int pageSize;

  const ProductsState({
    this.products,
    this.productCategories,
    this.getProductsRequest = RequestsEnum.initial,
    this.isLoading = false,
    this.errorMessage = '',
    this.page = 1,
    this.pageSize = 100,
  });

  ProductsState copyWith({
    PaginatedResponse<ProductsEntity>? products,
    List<ProductCategoriesEntity>? productCategories,
    RequestsEnum? getProductsRequest,
    bool? isLoading,
    String? errorMessage,
    int? page,
    int? pageSize,
  }) {
    return ProductsState(
      products: products ?? this.products,
      productCategories: productCategories ?? this.productCategories,
      getProductsRequest: getProductsRequest ?? this.getProductsRequest,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object?> get props => [
    products,
    productCategories,
    getProductsRequest,
    isLoading,
    errorMessage,
    pageSize,
    page,
  ];
}

class ProductError extends ProductsState {
  const ProductError({
    required super.errorMessage,
    super.products,
    super.productCategories,
    super.getProductsRequest = RequestsEnum.failure,
    super.isLoading = false,
    super.page,
    super.pageSize,
  });
}

class AddingProduct extends ProductsState {
  const AddingProduct({
    super.products,
    super.productCategories,
    super.getProductsRequest = RequestsEnum.loading,
    super.isLoading = true,
    super.errorMessage = '',
    super.page,
    super.pageSize,
  });
}

class ProductAdded extends ProductsState {
  const ProductAdded({
    super.products,
    super.productCategories,
    super.getProductsRequest = RequestsEnum.success,
    super.isLoading = false,
    super.errorMessage = '',
    super.page,
    super.pageSize,
  });
}

class UpdatingProduct extends ProductsState {
  const UpdatingProduct({
    super.products,
    super.productCategories,
    super.getProductsRequest = RequestsEnum.loading,
    super.isLoading = true,
    super.errorMessage = '',
    super.page,
    super.pageSize,
  });
}

class ProductUpdated extends ProductsState {
  const ProductUpdated({
    super.products,
    super.productCategories,
    super.getProductsRequest = RequestsEnum.success,
    super.isLoading = false,
    super.errorMessage = '',
    super.page,
    super.pageSize,
  });
}
