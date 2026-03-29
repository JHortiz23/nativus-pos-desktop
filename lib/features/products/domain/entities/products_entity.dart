import 'package:equatable/equatable.dart';

class ProductsEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final bool isActive;
  final String createdAt;
  final double price;

  const ProductsEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.createdAt,
    required this.price,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    isActive,
    createdAt,
    price,
  ];

  ProductsEntity copyWith({
    int? id,
    String? name,
    String? description,
    bool? isActive,
    String? createdAt,
    double? price,
  }) {
    return ProductsEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      price: price ?? this.price,
    );
  }
}
