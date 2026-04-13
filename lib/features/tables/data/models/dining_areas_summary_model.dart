import 'package:nativus_pos_desktop/core/utils/helpers/json_parsing_helper.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_areas_summary_entity.dart';

class DiningAreasSummaryModel {
  final int totalTables;
  final int availableTables;
  final int occupiedTables;

  DiningAreasSummaryModel({
    required this.totalTables,
    required this.availableTables,
    required this.occupiedTables,
  });

  factory DiningAreasSummaryModel.fromJson(Map<String, dynamic> json) {
    return DiningAreasSummaryModel(
      totalTables: JsonParsingHelper.asInt(json['totalTables']),
      availableTables: JsonParsingHelper.asInt(json['availableTables']),
      occupiedTables: JsonParsingHelper.asInt(json['occupiedTables']),
    );
  }

  DiningAreasSummaryModel copyWith({
    int? totalTables,
    int? availableTables,
    int? occupiedTables,
  }) {
    return DiningAreasSummaryModel(
      totalTables: totalTables ?? this.totalTables,
      availableTables: availableTables ?? this.availableTables,
      occupiedTables: occupiedTables ?? this.occupiedTables,
    );
  }

  factory DiningAreasSummaryModel.fromEntity(DiningAreasSummaryEntity entity) {
    return DiningAreasSummaryModel(
      totalTables: entity.totalTables,
      availableTables: entity.availableTables,
      occupiedTables: entity.occupiedTables,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalTables': totalTables,
      'availableTables': availableTables,
      'occupiedTables': occupiedTables,
    };
  }
}
