part of 'products_bloc.dart';

class ProductsState extends Equatable {
  final PaginatedResponse<ProductsEntity>? products;
  final RequestsEnum getProductsRequest;
  final bool isLoading;
  final String errorMessage;
  final int page;
  final int pageSize;

  const ProductsState({
    this.products,
    this.getProductsRequest = RequestsEnum.initial,
    this.isLoading = false,
    this.errorMessage = '',
    this.page = 1,
    this.pageSize = 100,
  });

  ProductsState copyWith({
    PaginatedResponse<ProductsEntity>? products,
    RequestsEnum? getProductsRequest,
    bool? isLoading,
    String? errorMessage,
    int? page,
    int? pageSize,
  }) {
    return ProductsState(
      products: products ?? this.products,
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
    getProductsRequest,
    isLoading,
    errorMessage,
    pageSize,
    page,
  ];
}
