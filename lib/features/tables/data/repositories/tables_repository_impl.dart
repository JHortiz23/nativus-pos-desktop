import 'package:nativus_pos_desktop/features/tables/data/datasources/remote/tables_remote_datasource.dart';
import 'package:nativus_pos_desktop/features/tables/data/mappers/dining_areas_response_mapper.dart';
import 'package:nativus_pos_desktop/features/tables/data/mappers/table_mapper.dart';
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

  // @override
  // Future<PaginatedResponse<ProductsEntity>> getProducts({
  //   int page = 1,
  //   int pageSize = 100,
  // }) async {
  //   final userReviewModels = await remoteDataSource.getProducts(
  //     page: page,
  //     pageSize: pageSize,
  //   );

  //   final mappedItems = userReviewModels.items
  //       .map((model) => ProductsMapper.toEntity(model))
  //       .toList(growable: false);

  //   return PaginatedResponse<ProductsEntity>(
  //     items: mappedItems,
  //     pageInfo: userReviewModels.pageInfo,
  //     filters: userReviewModels.filters,
  //     detectedItemsKey: userReviewModels.detectedItemsKey,
  //   );
  // }

  @override
  Future<DiningAreasResponseEntity> getDiningAreas() async {
    final response = await remoteDataSource.getDiningAreas();

    return DiningAreasResponseMapper.toEntity(response);
  }

  // @override
  // Future<ProductsEntity> updateProduct({
  //   required int id,
  //   required int categoryId,
  //   required String name,
  //   required String description,
  //   required double price,
  //   required bool isActive,
  // }) async {
  //   final model = await remoteDataSource.updateProduct(
  //     id: id,
  //     categoryId: categoryId,
  //     name: name,
  //     description: description,
  //     price: price,
  //     isActive: isActive,
  //   );

  //   return ProductsMapper.toEntity(model);
  // }

  // @override
  // Future<ProductsEntity> deleteProduct({required int id}) async {
  //   final model = await remoteDataSource.deleteProduct(id: id);

  //   return ProductsMapper.toEntity(model);
  // }
}
