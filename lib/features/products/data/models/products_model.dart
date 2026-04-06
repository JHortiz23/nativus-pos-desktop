import 'package:nativus_pos_desktop/core/utils/helpers/json_parsing_helper.dart';
import 'package:nativus_pos_desktop/features/products/data/mappers/products_mapper.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/products_entity.dart';

class ProductModel {
  final int id;
  final int? categoryId;
  final String categoryName;
  final String name;
  final String description;
  final bool isActive;
  final String createdAt;
  final double price;

  ProductModel({
    required this.id,
    this.categoryId,
    required this.categoryName,
    required this.name,
    required this.description,
    required this.isActive,
    required this.createdAt,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final category = JsonParsingHelper.asMap(json['category']);

    return ProductModel(
      id: JsonParsingHelper.asInt(json['id']),
      categoryId: _parseCategoryId(json, category),
      categoryName: JsonParsingHelper.asString(category['name']),
      name: JsonParsingHelper.asString(json['name']),
      description: JsonParsingHelper.asString(json['description']),
      isActive: JsonParsingHelper.asBool(json['isActive']),
      createdAt: JsonParsingHelper.asString(json['createdAt']),
      price: JsonParsingHelper.asDouble(json['price']),
    );
  }

  ProductModel copyWith({
    int? id,
    int? categoryId,
    String? categoryName,
    String? name,
    String? description,
    bool? isActive,
    String? createdAt,
    double? price,
  }) {
    return ProductModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      price: price ?? this.price,
    );
  }

  factory ProductModel.fromEntity(ProductsEntity entity) {
    return ProductsMapper.fromEntity(entity);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'name': name,
      'description': description,
      'isActive': isActive,
      'createdAt': createdAt,
      'price': price,
    };
  }

  static int? _parseCategoryId(
    Map<String, dynamic> json,
    Map<String, dynamic> category,
  ) {
    final rawCategoryId =
        json['categoryId'] ?? json['category_id'] ?? json['productCategoryId'];

    if (rawCategoryId != null) {
      return JsonParsingHelper.asInt(rawCategoryId);
    }

    if (category.isNotEmpty && category['id'] != null) {
      return JsonParsingHelper.asInt(category['id']);
    }

    return null;
  }
}
