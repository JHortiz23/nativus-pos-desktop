import 'package:equatable/equatable.dart';

class ProductCategoriesEntity extends Equatable {
  final int id;
  final String name;
  final bool isActive;
  final bool isDeleted;

  const ProductCategoriesEntity({
    required this.id,
    required this.name,
    required this.isActive,
    required this.isDeleted,
  });

  @override
  List<Object?> get props => [id, name, isActive, isDeleted];

  ProductCategoriesEntity copyWith({
    int? id,
    String? name,
    bool? isActive,
    bool? isDeleted,
  }) {
    return ProductCategoriesEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
