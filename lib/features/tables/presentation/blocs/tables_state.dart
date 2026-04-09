part of 'tables_bloc.dart';

class   TablesState extends Equatable {
  // final PaginatedResponse<ProductsEntity>? products;
  final List<DiningAreaEntity>? diningAreas;
  final bool isLoading;
  final String errorMessage;
  final int page;
  final int pageSize;

  const TablesState({
    // this.products,
    this.diningAreas,
    this.isLoading = false,
    this.errorMessage = '',
    this.page = 1,
    this.pageSize = 100,
  });

  TablesState copyWith({
    PaginatedResponse<ProductsEntity>? products,
    List<DiningAreaEntity>? diningAreas,
    RequestsEnum? getProductsRequest,
    bool? isLoading,
    String? errorMessage,
    int? page,
    int? pageSize,
  }) {
    return TablesState(
      // products: products ?? this.products,
      diningAreas: diningAreas ?? this.diningAreas,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object?> get props => [
    // products,
    diningAreas,
    // getProductsRequest,
    isLoading,
    errorMessage,
    pageSize,
    page,
  ];
}

class TablesError extends TablesState {
  const TablesError({
    required super.errorMessage,
    // super.products,
    super.diningAreas,
    // super.getProductsRequest = RequestsEnum.failure,
    super.isLoading = false,
    super.page,
    super.pageSize,
  });
}

class LoadingDiningAreas extends TablesState {
  const LoadingDiningAreas({
    // super.products,
    super.diningAreas,
    // super.getProductsRequest = RequestsEnum.loading,
    super.isLoading = true,
    super.errorMessage = '',
    super.page,
    super.pageSize,
  });
}

class DiningAreasLoaded extends TablesState {
  const DiningAreasLoaded({
    // super.products,
    super.diningAreas,
    // super.getProductsRequest = RequestsEnum.success,
    super.isLoading = false,
    super.errorMessage = '',
    super.page,
    super.pageSize,
  });
}

// class AddingProduct extends TablesState {
//   const AddingProduct({
//     // super.products,
//     super.diningAreas,
//     // super.getProductsRequest = RequestsEnum.loading,
//     super.isLoading = true,
//     super.errorMessage = '',
//     super.page,
//     super.pageSize,
//   });
// }

// class ProductAdded extends TablesState {
//   const ProductAdded({
//     // super.products,
//     super.diningAreas,
//     // super.getProductsRequest = RequestsEnum.success,
//     super.isLoading = false,
//     super.errorMessage = '',
//     super.page,
//     super.pageSize,
//   });
// }

// class UpdatingProduct extends TablesState {
//   const UpdatingProduct({
//     // super.products,
//     super.diningAreas,
//     // super.getProductsRequest = RequestsEnum.loading,
//     super.isLoading = true,
//     super.errorMessage = '',
//     super.page,
//     super.pageSize,
//   });
// }

// class ProductUpdated extends TablesState {
//   const ProductUpdated({
//     // super.products,
//     super.diningAreas,
//     // super.getProductsRequest = RequestsEnum.success,
//     super.isLoading = false,
//     super.errorMessage = '',
//     super.page,
//     super.pageSize,
//   });
// }

// class DeletingProduct extends TablesState {
//   const DeletingProduct({
//     // super.products,
//     super.diningAreas,
//     // super.getProductsRequest = RequestsEnum.loading,
//     super.isLoading = true,
//     super.errorMessage = '',
//     super.page,
//     super.pageSize,
//   });
// }

// class ProductDeleted extends TablesState {
//   const ProductDeleted({
//     // super.products,
//     super.diningAreas,
//     // super.getProductsRequest = RequestsEnum.success,
//     super.isLoading = false,
//     super.errorMessage = '',
//     super.page,
//     super.pageSize,
//   });
// }
