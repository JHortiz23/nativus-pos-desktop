import 'package:equatable/equatable.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_area_entity.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_areas_summary_entity.dart';

class DiningAreasResponseEntity extends Equatable {
  final DiningAreasSummaryEntity summary;
  final List<DiningAreaEntity> diningAreas;

  const DiningAreasResponseEntity({
    required this.summary,
    required this.diningAreas,
  });

  @override
  List<Object?> get props => [
        summary,
        diningAreas,
      ];

  DiningAreasResponseEntity copyWith({
    DiningAreasSummaryEntity? summary,
    List<DiningAreaEntity>? diningAreas,
  }) {
    return DiningAreasResponseEntity(
      summary: summary ?? this.summary,
      diningAreas: diningAreas ?? this.diningAreas,
    );
  }
}
