import 'package:nativus_pos_desktop/features/tables/domain/entities/table_entity.dart';
import 'package:nativus_pos_desktop/features/tables/domain/repositories/tables_repository.dart';

class AddTableUseCase {
  final TablesRepository tablesRepository;

  AddTableUseCase({required this.tablesRepository});

  Future<TableEntity> call({
    required String name,
    required int seats,
    required int diningAreaId,
    required bool isActive,
  }) {
    return tablesRepository.addTable(
      name: name,
      seats: seats,
      diningAreaId: diningAreaId,
      isActive: isActive,
    );
  }
}
