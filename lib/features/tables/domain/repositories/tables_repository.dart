import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_area_entity.dart';
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
  Future<DiningAreaEntity> addDiningArea({
    required String name,
    required bool isActive,
    required int tables,
    required String tableName,
  });
  Future<DiningAreaEntity> updateDiningArea({
    required int id,
    required String name,
    required bool isActive,
  });
  Future<DiningAreaEntity> deleteDiningArea({required int id});
}
