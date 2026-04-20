import 'package:nativus_pos_desktop/features/tables/domain/entities/table_entity.dart';
import 'package:nativus_pos_desktop/features/tables/domain/repositories/tables_repository.dart';

class UpdateTableUseCase {
  final TablesRepository tablesRepository;

  UpdateTableUseCase({required this.tablesRepository});

  Future<TableEntity> call({
    required int id,
    required String name,
    required int seats,
    required int diningAreaId,
    required bool isActive,
  }) {
    return tablesRepository.updateTable(
      id: id,
      name: name,
      seats: seats,
      diningAreaId: diningAreaId,
      isActive: isActive,
    );
  }
}
