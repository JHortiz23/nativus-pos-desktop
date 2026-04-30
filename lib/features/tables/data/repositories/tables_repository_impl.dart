import 'package:nativus_pos_desktop/features/tables/data/datasources/remote/tables_remote_datasource.dart';
import 'package:nativus_pos_desktop/features/tables/data/mappers/dining_area_mapper.dart';
import 'package:nativus_pos_desktop/features/tables/data/mappers/dining_areas_response_mapper.dart';
import 'package:nativus_pos_desktop/features/tables/data/mappers/table_mapper.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_area_entity.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_areas_response_entity.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/table_entity.dart';
import 'package:nativus_pos_desktop/features/tables/domain/repositories/tables_repository.dart';

class TablesRepositoryImpl implements TablesRepository {
  final TablesRemoteDataSource remoteDataSource;

  TablesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<TableEntity> addTable({
    required String name,
    required int seats,
    required int diningAreaId,
    required bool isActive,
  }) async {
    final model = await remoteDataSource.addTable(
      name: name,
      seats: seats,
      diningAreaId: diningAreaId,
      isActive: isActive,
    );

    return TableMapper.toEntity(model);
  }

  @override
  Future<DiningAreasResponseEntity> getDiningAreas() async {
    final response = await remoteDataSource.getDiningAreas();

    return DiningAreasResponseMapper.toEntity(response);
  }

  @override
  Future<TableEntity> updateTable({
    required int id,
    required String name,
    required int seats,
    required int diningAreaId,
    required bool isActive,
  }) async {
    final model = await remoteDataSource.updateTable(
      id: id,
      name: name,
      seats: seats,
      diningAreaId: diningAreaId,
      isActive: isActive,
    );

    return TableMapper.toEntity(model);
  }

  @override
  Future<TableEntity> deleteTable({required int id}) async {
    final model = await remoteDataSource.deleteTable(id: id);

    return TableMapper.toEntity(model);
  }

  @override
  Future<DiningAreaEntity> addDiningArea({
    required String name,
    required bool isActive,
    required int tables,
    required String tableName,
  }) async {
    final model = await remoteDataSource.addDiningArea(
      name: name,
      isActive: isActive,
      tables: tables,
      tableName: tableName,
    );

    return DiningAreaMapper.toEntity(model);
  }

  @override
  Future<DiningAreaEntity> updateDiningArea({
    required int id,
    required String name,
    required bool isActive,
  }) async {
    final model = await remoteDataSource.updateDiningArea(
      id: id,
      name: name,
      isActive: isActive,
    );

    return DiningAreaMapper.toEntity(model);
  }

  @override
  Future<DiningAreaEntity> deleteDiningArea({required int id}) async {
    final model = await remoteDataSource.deleteDiningArea(id: id);

    return DiningAreaMapper.toEntity(model);
  }
}
