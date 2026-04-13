import 'package:nativus_pos_desktop/features/tables/data/models/dining_area_model.dart';
import 'package:nativus_pos_desktop/features/tables/data/models/table_summary_model.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/tables_response_entity.dart';

class TablesResponseModel {
  final TableSummaryModel summary;
  final List<DiningAreaModel> diningAreas;

  TablesResponseModel({
    required this.summary,
    required this.diningAreas,
  });

  factory TablesResponseModel.fromJson(Map<String, dynamic> json) {
    return TablesResponseModel(
      summary: TableSummaryModel.fromJson(json['summary'] ?? {}),
      diningAreas: (json['diningAreas'] as List<dynamic>?)
              ?.map((e) => DiningAreaModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  factory TablesResponseModel.fromEntity(TablesResponseEntity entity) {
    return TablesResponseModel(
      summary: TableSummaryModel.fromEntity(entity.summary),
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
