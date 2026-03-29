

import 'package:nativus_pos_desktop/core/shared/data/models/paginated_response.dart';
import 'package:nativus_pos_desktop/features/products/data/datasources/remote/products_remote_datasource.dart';
import 'package:nativus_pos_desktop/features/products/data/mappers/products_mapper.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/products_entity.dart';
import 'package:nativus_pos_desktop/features/products/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;

  ProductsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<PaginatedResponse<ProductsEntity>> getProducts({
    int page = 1,
    int pageSize = 100
  }) async {
    final userReviewModels = await remoteDataSource.getProducts(
      page: page,
      pageSize: pageSize
    );

    final mappedItems = userReviewModels.items
        .map((model) => ProductsMapper.toEntity(model))
        .toList(growable: false);

    return PaginatedResponse<ProductsEntity>(
      items: mappedItems,
      pageInfo: userReviewModels.pageInfo,
      filters: userReviewModels.filters,
      detectedItemsKey: userReviewModels.detectedItemsKey,
    );
  }
}
