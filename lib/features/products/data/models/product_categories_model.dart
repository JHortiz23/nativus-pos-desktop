import 'package:nativus_pos_desktop/core/utils/helpers/json_parsing_helper.dart';
import 'package:nativus_pos_desktop/features/products/data/mappers/product_categories_mapper.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/product_categories_entity.dart';

class ProductCategoriesModel {
  final int id;
  final String name;
  final bool isActive;
  final bool isDeleted;

  ProductCategoriesModel({
    required this.id,
    required this.name,
    required this.isActive,
    required this.isDeleted ,
  });

  factory ProductCategoriesModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoriesModel(
      id: JsonParsingHelper.asInt(json['id']),
      name: JsonParsingHelper.asString(json['name']),
      isActive: JsonParsingHelper.asBool(json['isActive']),
      isDeleted: JsonParsingHelper.asBool(json['isDeleted'] ?? json['isDleted']),
    );
  }

  ProductCategoriesModel copyWith({
    int? id,
    String? name,
    bool? isActive,
    bool? isDeleted,
  }) {
    return ProductCategoriesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  factory ProductCategoriesModel.fromEntity(ProductCategoriesEntity entity) {
    return ProductCategoriesMapper.fromEntity(entity);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isActive': isActive,
      'isDeleted': isDeleted,
    };
  }
}
