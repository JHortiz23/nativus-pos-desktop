part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

/// Event to add a new product
class AddProductEvent extends ProductsEvent {
  final int categoryId;
  final String name;
  final String description;
  final double price;
  final bool isActive;

  const AddProductEvent({
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.isActive,
  });

  @override
  List<Object?> get props => [categoryId, name, description, price, isActive];
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

/// Event to update an existing product
class UpdateProductEvent extends ProductsEvent {
  final int id;
  final int categoryId;
  final String name;
  final String description;
  final double price;
  final bool isActive;

  const UpdateProductEvent({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.isActive,
  });

  @override
  List<Object?> get props => [id, categoryId, name, description, price, isActive];
}

/// Event to delete a product
class DeleteProductEvent extends ProductsEvent {
  final int id;

  const DeleteProductEvent({required this.id});

  @override
  List<Object?> get props => [id];
}