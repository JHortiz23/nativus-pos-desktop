import 'package:nativus_pos_desktop/features/tables/domain/entities/table_entity.dart';
import 'package:nativus_pos_desktop/features/tables/domain/repositories/tables_repository.dart';

class DeleteTableUseCase {
  final TablesRepository tablesRepository;

  DeleteTableUseCase({required this.tablesRepository});

  Future<TableEntity> call({required int id}) {
    return tablesRepository.deleteTable(id: id);
  }
}
