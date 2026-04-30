import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_area_entity.dart';
import 'package:nativus_pos_desktop/features/tables/domain/repositories/tables_repository.dart';

class DeleteDiningAreaUseCase {
  final TablesRepository tablesRepository;

  DeleteDiningAreaUseCase({required this.tablesRepository});

  Future<DiningAreaEntity> call({required int id}) {
    return tablesRepository.deleteDiningArea(id: id);
  }
}
