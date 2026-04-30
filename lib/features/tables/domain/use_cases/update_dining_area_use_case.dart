import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_area_entity.dart';
import 'package:nativus_pos_desktop/features/tables/domain/repositories/tables_repository.dart';

class UpdateDiningAreaUseCase {
  final TablesRepository tablesRepository;

  UpdateDiningAreaUseCase({required this.tablesRepository});

  Future<DiningAreaEntity> call({
    required int id,
    required String name,
    required bool isActive,
  }) {
    return tablesRepository.updateDiningArea(
      id: id,
      name: name,
      isActive: isActive,
    );
  }
}
