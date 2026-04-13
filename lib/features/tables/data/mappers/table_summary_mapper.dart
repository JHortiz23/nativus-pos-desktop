import 'package:nativus_pos_desktop/features/tables/data/models/dining_areas_summary_model.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_areas_summary_entity.dart';

class DiningAreasSummaryMapper {
  static DiningAreasSummaryEntity toEntity(DiningAreasSummaryModel model) {
    return DiningAreasSummaryEntity(
      totalTables: model.totalTables,
      availableTables: model.availableTables,
      occupiedTables: model.occupiedTables,
    );
  }

  static DiningAreasSummaryModel fromEntity(DiningAreasSummaryEntity entity) {
    return DiningAreasSummaryModel.fromEntity(entity);
  }
}
