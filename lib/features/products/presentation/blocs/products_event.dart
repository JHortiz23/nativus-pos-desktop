part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

/// Event to get products with optional filters and pagination
class GetProductsEvent extends ProductsEvent {
  final int page;
  final int pageSize;

  const GetProductsEvent({this.page = 1, this.pageSize = 100});

  @override
  List<Object?> get props => [page, pageSize];
}

/// Event to get product categories
class GetProductCategoriesEvent extends ProductsEvent {
  const GetProductCategoriesEvent();

  @override
  List<Object?> get props => [];
}
