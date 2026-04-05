import 'package:nativus_pos_desktop/core/shared/data/models/paginated_response.dart';
import 'package:nativus_pos_desktop/features/products/data/datasources/remote/products_remote_datasource.dart';
import 'package:nativus_pos_desktop/features/products/data/mappers/added_product_mapper.dart';
import 'package:nativus_pos_desktop/features/products/data/mappers/product_categories_mapper.dart';
import 'package:nativus_pos_desktop/features/products/data/mappers/products_mapper.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/added_product_entity.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/product_categories_entity.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/products_entity.dart';
import 'package:nativus_pos_desktop/features/products/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;

  ProductsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AddedProductEntity> addProduct({
    required int categoryId,
    required String name,
    required String description,
    required double price,
    required bool isActive,
  }) async {
    final model = await remoteDataSource.addProduct(
      categoryId: categoryId,
      name: name,
      description: description,
      price: price,
      isActive: isActive,
    );

    return AddedProductMapper.toEntity(model);
  }

  @override
  Future<PaginatedResponse<ProductsEntity>> getProducts({
    int page = 1,
    int pageSize = 100,
  }) async {
    final userReviewModels = await remoteDataSource.getProducts(
      page: page,
      pageSize: pageSize,
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

  @override
  Future<List<ProductCategoriesEntity>> getProductCategories() async {
    final categoryModels = await remoteDataSource.getProductCategories();

    return categoryModels
        .map((model) => ProductCategoriesMapper.toEntity(model))
        .toList(growable: false);
  }

  @override
  Future<ProductsEntity> updateProduct({
    required int id,
    required int categoryId,
    required String name,
    required String description,
    required double price,
    required bool isActive,
  }) async {
    final model = await remoteDataSource.updateProduct(
      id: id,
      categoryId: categoryId,
      name: name,
      description: description,
      price: price,
      isActive: isActive,
    );

    return ProductsMapper.toEntity(model);
  }
}
