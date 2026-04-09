import 'package:nativus_pos_desktop/core/utils/helpers/json_parsing_helper.dart';
import 'package:nativus_pos_desktop/features/tables/data/mappers/dining_area_mapper.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_area_entity.dart';

class DiningAreaModel {
  final int id;
  final String name;
  final bool isActive;

  DiningAreaModel({
    required this.id,
    required this.name,
    required this.isActive,
  });

  factory DiningAreaModel.fromJson(Map<String, dynamic> json) {
    return DiningAreaModel(
      id: JsonParsingHelper.asInt(json['id']),
      name: JsonParsingHelper.asString(json['name']),
      isActive: JsonParsingHelper.asBool(json['isActive']),
    );
  }

  DiningAreaModel copyWith({
    int? id,
    String? name,
    int? restaurantId,
    bool? isActive,
  }) {
    return DiningAreaModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
    );
  }

  factory DiningAreaModel.fromEntity(DiningAreaEntity entity) {
    return DiningAreaMapper.fromEntity(entity);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isActive': isActive,
    };
  }

  // static int? _parseCategoryId(
  //   Map<String, dynamic> json,
  //   Map<String, dynamic> category,
  // ) {
  //   final rawCategoryId =
  //       json['categoryId'] ?? json['category_id'] ?? json['productCategoryId'];

  //   if (rawCategoryId != null) {
  //     return JsonParsingHelper.asInt(rawCategoryId);
  //   }

  //   if (category.isNotEmpty && category['id'] != null) {
  //     return JsonParsingHelper.asInt(category['id']);
  //   }

  //   return null;
  // }
}
