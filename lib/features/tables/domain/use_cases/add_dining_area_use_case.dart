import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_area_entity.dart';
import 'package:nativus_pos_desktop/features/tables/domain/repositories/tables_repository.dart';

class AddDiningAreaUseCase {
  final TablesRepository tablesRepository;

  AddDiningAreaUseCase({required this.tablesRepository});

  Future<DiningAreaEntity> call({
    required String name,
    required bool isActive,
    required int tables,
    required String tableName,
  }) {
    return tablesRepository.addDiningArea(
      name: name,
      isActive: isActive,
      tables: tables,
      tableName: tableName,
    );
  }
}
