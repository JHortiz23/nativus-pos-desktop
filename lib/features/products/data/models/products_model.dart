import 'package:nativus_pos_desktop/core/utils/helpers/json_parsing_helper.dart';
import 'package:nativus_pos_desktop/features/products/data/mappers/products_mapper.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/products_entity.dart';

class ProductsModel {
  final int id;
  final String name;
  final String description;
  final bool isActive;
  final String createdAt;
  final double price;

  ProductsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.createdAt,
    required this.price,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: JsonParsingHelper.asInt(json['id']),
      name: JsonParsingHelper.asString(json['name']),
      description: JsonParsingHelper.asString(json['description']),
      isActive: JsonParsingHelper.asBool(json['isActive']),
      createdAt: JsonParsingHelper.asString(json['createdAt']),
      price: JsonParsingHelper.asDouble(json['price']),
    );
  }

  ProductsModel copyWith({
    int? id,
    String? name,
    String? description,
    bool? isActive,
    String? createdAt,
    double? price,
  }) {
    return ProductsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      price: price ?? this.price,
    );
  }

  factory ProductsModel.fromEntity(ProductsEntity entity) {
    return ProductsMapper.fromEntity(entity);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'isActive': isActive,
      'createdAt': createdAt,
      'price': price,
    };
  }
}
