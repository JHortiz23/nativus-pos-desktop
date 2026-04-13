import 'package:nativus_pos_desktop/features/tables/data/models/dining_area_model.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_area_entity.dart';
import 'package:nativus_pos_desktop/features/tables/data/mappers/table_mapper.dart';

class DiningAreaMapper {
  static DiningAreaEntity toEntity(DiningAreaModel model) {
    return DiningAreaEntity(
      id: model.id,
      name: model.name,
      isActive: model.isActive,
      tablesCount: model.tablesCount,
      availableCount: model.availableCount,
      occupiedCount: model.occupiedCount,
      tables: model.tables.map((t) => TableMapper.toEntity(t)).toList(),
    );
  }

  static DiningAreaModel fromEntity(DiningAreaEntity entity) {
    return DiningAreaModel(
      id: entity.id,
      name: entity.name,
      isActive: entity.isActive,
      tablesCount: entity.tablesCount,
      availableCount: entity.availableCount,
      occupiedCount: entity.occupiedCount,
      tables: entity.tables.map((t) => TableMapper.fromEntity(t)).toList(),
    );
  }
}

