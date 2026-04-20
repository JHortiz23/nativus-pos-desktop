import 'package:nativus_pos_desktop/features/tables/data/models/table_model.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/table_entity.dart';

class TableMapper {
  static TableEntity toEntity(TableModel model) {
    return TableEntity(
      id: model.id,
      diningAreaId: model.diningAreaId,
      isActive: model.isActive,
      name: model.name,
      status: model.status,
      seats: model.seats,
    );
  }

  static TableModel fromEntity(TableEntity entity) {
    return TableModel.fromEntity(entity);
  }
}
