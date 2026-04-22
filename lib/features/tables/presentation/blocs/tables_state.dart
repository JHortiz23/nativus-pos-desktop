part of 'tables_bloc.dart';

class TablesState extends Equatable {
  final List<DiningAreaEntity>? diningAreas;
  final DiningAreasSummaryEntity? summary;
  final bool isLoading;
  final String errorMessage;
  final int page;
  final int pageSize;

  const TablesState({
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
    diningAreas,
    summary,
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

class UpdatingTable extends TablesState {
  const UpdatingTable({
    super.diningAreas,
    super.summary,
    super.isLoading = true,
    super.errorMessage = '',
    super.page,
    super.pageSize,
  });
}

class TableUpdated extends TablesState {
  const TableUpdated({
    super.diningAreas,
    super.summary,
    super.isLoading = false,
    super.errorMessage = '',
    super.page,
    super.pageSize,
  });
}

class DeletingTable extends TablesState {
  const DeletingTable({
    super.diningAreas,
    super.summary,
    super.isLoading = true,
    super.errorMessage = '',
    super.page,
    super.pageSize,
  });
}

class TableDeleted extends TablesState {
  const TableDeleted({
    super.diningAreas,
    super.summary,
    super.isLoading = false,
    super.errorMessage = '',
    super.page,
    super.pageSize,
  });
}

class AddingDiningArea extends TablesState {
  const AddingDiningArea({
    super.diningAreas,
    super.summary,
    super.isLoading = true,
    super.errorMessage = '',
    super.page,
    super.pageSize,
  });
}

class DiningAreaAdded extends TablesState {
  const DiningAreaAdded({
    super.diningAreas,
    super.summary,
    super.isLoading = false,
    super.errorMessage = '',
    super.page,
    super.pageSize,
  });
}
