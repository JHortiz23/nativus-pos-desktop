part of 'tables_bloc.dart';

abstract class TablesEvent extends Equatable {
  const TablesEvent();

  @override
  List<Object?> get props => [];
}

/// Event to add a new product
// class AddProductEvent extends TablesEvent {
//   final int categoryId;
//   final String name;
//   final String description;
//   final double price;
//   final bool isActive;

//   const AddProductEvent({
//     required this.categoryId,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.isActive,
//   });

//   @override
//   List<Object?> get props => [categoryId, name, description, price, isActive];
// }

/// Event to get products with optional filters and pagination
// class GetProductsEvent extends TablesEvent {
//   final int page;
//   final int pageSize;

//   const GetProductsEvent({this.page = 1, this.pageSize = 100});

//   @override
//   List<Object?> get props => [page, pageSize];
// }

/// Event to get product categories
class GetDiningAreasEvent extends TablesEvent {
  const GetDiningAreasEvent();

  @override
  List<Object?> get props => [];
}

/// Event to update an existing product
// class UpdateProductEvent extends TablesEvent {
//   final int id;
//   final int categoryId;
//   final String name;
//   final String description;
//   final double price;
//   final bool isActive;

//   const UpdateProductEvent({
//     required this.id,
//     required this.categoryId,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.isActive,
//   });

//   @override
//   List<Object?> get props => [id, categoryId, name, description, price, isActive];
// }

/// Event to delete a product
// class DeleteProductEvent extends TablesEvent {
//   final int id;

//   const DeleteProductEvent({required this.id});

//   @override
//   List<Object?> get props => [id];
// }