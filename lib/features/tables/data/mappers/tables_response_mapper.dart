import 'package:nativus_pos_desktop/features/tables/data/mappers/dining_area_mapper.dart';
import 'package:nativus_pos_desktop/features/tables/data/mappers/table_summary_mapper.dart';
import 'package:nativus_pos_desktop/features/tables/data/models/tables_response_model.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/tables_response_entity.dart';

class TablesResponseMapper {
  static TablesResponseEntity toEntity(TablesResponseModel model) {
    return TablesResponseEntity(
      summary: TableSummaryMapper.toEntity(model.summary),
      diningAreas: model.diningAreas
          .map((area) => DiningAreaMapper.toEntity(area))
          .toList(),
    );
  }

  static TablesResponseModel fromEntity(TablesResponseEntity entity) {
    return TablesResponseModel.fromEntity(entity);
  }
}
