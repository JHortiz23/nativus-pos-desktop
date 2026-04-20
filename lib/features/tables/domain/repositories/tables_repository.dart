import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_areas_response_entity.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/table_entity.dart';

abstract class TablesRepository {
  Future<TableEntity> addTable({
    required String name,
    required int seats,
    required int diningAreaId,
    required bool isActive,
  });

  Future<DiningAreasResponseEntity> getDiningAreas();
  Future<TableEntity> updateTable({
    required int id,
    required String name,
    required int seats,
    required int diningAreaId,
    required bool isActive,
  });
  Future<TableEntity> deleteTable({required int id});
}
