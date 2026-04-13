import 'package:nativus_pos_desktop/features/tables/data/models/table_summary_model.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/table_summary_entity.dart';

class TableSummaryMapper {
  static TableSummaryEntity toEntity(TableSummaryModel model) {
    return TableSummaryEntity(
      totalTables: model.totalTables,
      availableTables: model.availableTables,
      occupiedTables: model.occupiedTables,
    );
  }

  static TableSummaryModel fromEntity(TableSummaryEntity entity) {
    return TableSummaryModel.fromEntity(entity);
  }
}
