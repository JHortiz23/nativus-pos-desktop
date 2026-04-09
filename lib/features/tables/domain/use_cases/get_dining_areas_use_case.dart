

import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_area_entity.dart';
import 'package:nativus_pos_desktop/features/tables/domain/repositories/tables_repository.dart';

class GetDiningAreasUseCase {
  final TablesRepository tablesRepository;

  GetDiningAreasUseCase({required this.tablesRepository});

  Future<List<DiningAreaEntity>> call() {
    return tablesRepository.getDiningAreas();
  }
}