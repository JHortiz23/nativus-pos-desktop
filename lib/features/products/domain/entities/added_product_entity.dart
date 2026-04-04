import 'package:equatable/equatable.dart';

class AddedProductEntity extends Equatable {
  final int id;
  final int restaurantId;
  final int categoryId;
  final String name;
  final String description;
  final double price;
  final bool isActive;

  const AddedProductEntity({
    required this.id,
    required this.restaurantId,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.isActive,
  });

  @override
  List<Object?> get props => [
    id,
    restaurantId,
    categoryId,
    name,
    description,
    price,
    isActive,
  ];

  AddedProductEntity copyWith({
    int? id,
    int? restaurantId,
    int? categoryId,
    String? name,
    String? description,
    double? price,
    bool? isActive,
  }) {
    return AddedProductEntity(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      isActive: isActive ?? this.isActive,
    );
  }
}
