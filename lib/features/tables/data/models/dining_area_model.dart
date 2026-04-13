import 'package:nativus_pos_desktop/core/utils/helpers/json_parsing_helper.dart';
import 'package:nativus_pos_desktop/features/tables/data/mappers/dining_area_mapper.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_area_entity.dart';
import 'package:nativus_pos_desktop/features/tables/data/models/table_model.dart';

class DiningAreaModel {
  final int id;
  final String name;
  final bool isActive;
  final int tablesCount;
  final int availableCount;
  final int occupiedCount;
  final List<TableModel> tables;

  DiningAreaModel({
    required this.id,
    required this.name,
    required this.isActive,
    required this.tablesCount,
    required this.availableCount,
    required this.occupiedCount,
    required this.tables,
  });

  factory DiningAreaModel.fromJson(Map<String, dynamic> json) {
    return DiningAreaModel(
      id: JsonParsingHelper.asInt(json['id']),
      name: JsonParsingHelper.asString(json['name']),
      isActive: json['isActive'] != null ? JsonParsingHelper.asBool(json['isActive']) : true,
      tablesCount: JsonParsingHelper.asInt(json['tablesCount']),
      availableCount: JsonParsingHelper.asInt(json['availableCount']),
      occupiedCount: JsonParsingHelper.asInt(json['occupiedCount']),
      tables: (json['tables'] as List<dynamic>?)
              ?.map((e) => TableModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  DiningAreaModel copyWith({
    int? id,
    String? name,
    bool? isActive,
    int? tablesCount,
    int? availableCount,
    int? occupiedCount,
    List<TableModel>? tables,
  }) {
    return DiningAreaModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      tablesCount: tablesCount ?? this.tablesCount,
      availableCount: availableCount ?? this.availableCount,
      occupiedCount: occupiedCount ?? this.occupiedCount,
      tables: tables ?? this.tables,
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
      'tablesCount': tablesCount,
      'availableCount': availableCount,
      'occupiedCount': occupiedCount,
      'tables': tables.map((e) => e.toJson()).toList(),
    };
  }
}

