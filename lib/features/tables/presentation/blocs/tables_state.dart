part of 'tables_bloc.dart';

class TablesState extends Equatable {
  // final PaginatedResponse<ProductsEntity>? products;
  final List<DiningAreaEntity>? diningAreas;
  final DiningAreasSummaryEntity? summary;
  final bool isLoading;
  final String errorMessage;
  final int page;
  final int pageSize;

  const TablesState({
    // this.products,
    this.diningAreas,
    this.summary,
    this.isLoading = false,
    this.errorMessage = '',
    this.page = 1,
    this.pageSize = 100,
  });

  TablesState copyWith({
    PaginatedResponse<ProductsEntity>? products,
    List<DiningAreaEntity>? diningAreas,
    DiningAreasSummaryEntity? summary,
    RequestsEnum? getProductsRequest,
    bool? isLoading,
    String? errorMessage,
    int? page,
    int? pageSize,
  }) {
    return TablesState(
      // products: products ?? this.products,
      diningAreas: diningAreas ?? this.diningAreas,
      summary: summary ?? this.summary,
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
    summary,
    // getProductsRequest,
    isLoading,
    errorMessage,
    pageSize,
    page,
  ];
}

class TableError extends TablesState {
  const TableError({
    required super.errorMessage,
    super.diningAreas,
    super.summary,
    super.isLoading = false,
    super.page,
    super.pageSize,
  });
}

class LoadingDiningAreas extends TablesState {
  const LoadingDiningAreas({
    super.diningAreas,
    super.summary,
    super.isLoading = true,
    super.errorMessage = '',
    super.page,
    super.pageSize,
  });
}

class DiningAreasLoaded extends TablesState {
  const DiningAreasLoaded({
    super.diningAreas,
    super.summary,
    super.isLoading = false,
    super.errorMessage = '',
    super.page,
    super.pageSize,
  });
}

class AddingTable extends TablesState {
  const AddingTable({
    super.diningAreas,
    super.summary,
    super.isLoading = true,
    super.errorMessage = '',
    super.page,
    super.pageSize,
  });
}

class TableAdded extends TablesState {
  const TableAdded({
    super.diningAreas,
    super.summary,
    super.isLoading = false,
    super.errorMessage = '',
    super.page,
    super.pageSize,
  });
}

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
