import 'package:equatable/equatable.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_area_entity.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/table_summary_entity.dart';

class TablesResponseEntity extends Equatable {
  final TableSummaryEntity summary;
  final List<DiningAreaEntity> diningAreas;

  const TablesResponseEntity({
    required this.summary,
    required this.diningAreas,
  });

  @override
  List<Object?> get props => [
        summary,
        diningAreas,
      ];

  TablesResponseEntity copyWith({
    TableSummaryEntity? summary,
    List<DiningAreaEntity>? diningAreas,
  }) {
    return TablesResponseEntity(
      summary: summary ?? this.summary,
      diningAreas: diningAreas ?? this.diningAreas,
    );
  }
}
