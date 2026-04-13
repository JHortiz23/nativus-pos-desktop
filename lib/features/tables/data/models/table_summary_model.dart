import 'package:nativus_pos_desktop/core/utils/helpers/json_parsing_helper.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/table_summary_entity.dart';

class TableSummaryModel {
  final int totalTables;
  final int availableTables;
  final int occupiedTables;

  TableSummaryModel({
    required this.totalTables,
    required this.availableTables,
    required this.occupiedTables,
  });

  factory TableSummaryModel.fromJson(Map<String, dynamic> json) {
    return TableSummaryModel(
      totalTables: JsonParsingHelper.asInt(json['totalTables']),
      availableTables: JsonParsingHelper.asInt(json['availableTables']),
      occupiedTables: JsonParsingHelper.asInt(json['occupiedTables']),
    );
  }

  TableSummaryModel copyWith({
    int? totalTables,
    int? availableTables,
    int? occupiedTables,
  }) {
    return TableSummaryModel(
      totalTables: totalTables ?? this.totalTables,
      availableTables: availableTables ?? this.availableTables,
      occupiedTables: occupiedTables ?? this.occupiedTables,
    );
  }

  factory TableSummaryModel.fromEntity(TableSummaryEntity entity) {
    return TableSummaryModel(
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
