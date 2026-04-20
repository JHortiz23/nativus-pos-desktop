import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_areas_response_entity.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/table_entity.dart';

abstract class TablesRepository {
  Future<TableEntity> addTable({
    required String name,
    required int seats,
    required int diningAreaId,
    required bool isActive,
  });
  // Future<PaginatedResponse<ProductsEntity>> getProducts({
  //   int page = 1,
  //   int pageSize = 100,
  // });

  Future<DiningAreasResponseEntity> getDiningAreas();
  // Future<ProductsEntity> updateProduct({
  //   required int id,
  //   required int categoryId,
  //   required String name,
  //   required String description,
  //   required double price,
  //   required bool isActive,
  // });
  // Future<ProductsEntity> deleteProduct({required int id});
}
