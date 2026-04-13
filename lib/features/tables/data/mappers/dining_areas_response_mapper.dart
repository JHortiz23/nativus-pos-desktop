import 'package:nativus_pos_desktop/features/tables/data/mappers/dining_area_mapper.dart';
import 'package:nativus_pos_desktop/features/tables/data/mappers/table_summary_mapper.dart';
import 'package:nativus_pos_desktop/features/tables/data/models/dining_areas_response_model.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_areas_response_entity.dart';

class DiningAreasResponseMapper {
  static DiningAreasResponseEntity toEntity(DiningAreasResponseModel model) {
    return DiningAreasResponseEntity(
      summary: DiningAreasSummaryMapper.toEntity(model.summary),
      diningAreas: model.diningAreas
          .map((area) => DiningAreaMapper.toEntity(area))
          .toList(),
    );
  }

  static DiningAreasResponseModel fromEntity(DiningAreasResponseEntity entity) {
    return DiningAreasResponseModel.fromEntity(entity);
  }
}
