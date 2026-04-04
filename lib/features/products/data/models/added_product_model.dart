import 'package:nativus_pos_desktop/core/utils/helpers/json_parsing_helper.dart';
import 'package:nativus_pos_desktop/features/products/data/mappers/added_product_mapper.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/added_product_entity.dart';

class AddedProductModel {
  final int id;
  final int restaurantId;
  final int categoryId;
  final String name;
  final String description;
  final double price;
  final bool isActive;

  AddedProductModel({
    required this.id,
    required this.restaurantId,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.isActive,
  });

  factory AddedProductModel.fromJson(Map<String, dynamic> json) {
    return AddedProductModel(
      id: JsonParsingHelper.asInt(json['id']),
      restaurantId: JsonParsingHelper.asInt(json['restaurantId']),
      categoryId: JsonParsingHelper.asInt(json['categoryId']),
      name: JsonParsingHelper.asString(json['name']),
      description: JsonParsingHelper.asString(json['description']),
      price: JsonParsingHelper.asDouble(json['price']),
      isActive: JsonParsingHelper.asBool(json['isActive']),
    );
  }

  AddedProductModel copyWith({
    int? id,
    int? restaurantId,
    int? categoryId,
    String? name,
    String? description,
    double? price,
    bool? isActive,
  }) {
    return AddedProductModel(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      isActive: isActive ?? this.isActive,
    );
  }

  factory AddedProductModel.fromEntity(AddedProductEntity entity) {
    return AddedProductMapper.fromEntity(entity);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'categoryId': categoryId,
      'name': name,
      'description': description,
      'price': price,
      'isActive': isActive,
    };
  }
}
