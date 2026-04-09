import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_area_entity.dart';

abstract class TablesRepository {
  // Future<AddedProductEntity> addProduct({
  //   required int categoryId,
  //   required String name,
  //   required String description,
  //   required double price,
  //   required bool isActive,
  // });
  // Future<PaginatedResponse<ProductsEntity>> getProducts({
  //   int page = 1,
  //   int pageSize = 100,
  // });

  Future<List<DiningAreaEntity>> getDiningAreas();
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
