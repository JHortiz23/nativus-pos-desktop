import 'package:nativus_pos_desktop/features/tables/data/models/dining_area_model.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_area_entity.dart';

class DiningAreaMapper {
  static DiningAreaEntity toEntity(DiningAreaModel model) {
    return DiningAreaEntity(
      id: model.id,
      name: model.name,
      isActive: model.isActive,
    );
  }

  static DiningAreaModel fromEntity(DiningAreaEntity entity) {
    return DiningAreaModel(
      id: entity.id,
      name: entity.name,
      isActive: entity.isActive,
    );
  }
}
