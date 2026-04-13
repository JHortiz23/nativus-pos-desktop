import 'package:nativus_pos_desktop/features/tables/data/models/dining_area_model.dart';
import 'package:nativus_pos_desktop/features/tables/data/models/dining_areas_summary_model.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_areas_response_entity.dart';

class DiningAreasResponseModel {
  final DiningAreasSummaryModel summary;
  final List<DiningAreaModel> diningAreas;

  DiningAreasResponseModel({
    required this.summary,
    required this.diningAreas,
  });

  factory DiningAreasResponseModel.fromJson(Map<String, dynamic> json) {
    return DiningAreasResponseModel(
      summary: DiningAreasSummaryModel.fromJson(json['summary'] ?? {}),
      diningAreas: (json['diningAreas'] as List<dynamic>?)
              ?.map((e) => DiningAreaModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  factory DiningAreasResponseModel.fromEntity(DiningAreasResponseEntity entity) {
    return DiningAreasResponseModel(
      summary: DiningAreasSummaryModel.fromEntity(entity.summary),
      diningAreas: entity.diningAreas
          .map((area) => DiningAreaModel.fromEntity(area))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'summary': summary.toJson(),
      'diningAreas': diningAreas.map((e) => e.toJson()).toList(),
    };
  }
}
