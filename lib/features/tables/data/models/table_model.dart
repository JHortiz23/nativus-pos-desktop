import 'package:nativus_pos_desktop/core/utils/helpers/json_parsing_helper.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/table_entity.dart';

class TableModel {
  final int id;
  final String name;
  final String status;
  final int? seats;

  TableModel({
    required this.id,
    required this.name,
    required this.status,
    this.seats,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      id: JsonParsingHelper.asInt(json['id']),
      name: JsonParsingHelper.asString(json['name']),
      status: JsonParsingHelper.asString(json['status']),
      seats: json['seats'] != null ? JsonParsingHelper.asInt(json['seats']) : null,
    );
  }

  factory TableModel.fromEntity(TableEntity entity) {
    return TableModel(
      id: entity.id,
      name: entity.name,
      status: entity.status,
      seats: entity.seats,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'seats': seats,
    };
  }
}
