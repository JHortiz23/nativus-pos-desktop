import 'package:nativus_pos_desktop/core/shared/data/models/paginated_response.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/added_product_entity.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/product_categories_entity.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/products_entity.dart';

abstract class ProductsRepository {
  Future<AddedProductEntity> addProduct({
    required int categoryId,
    required String name,
    required String description,
    required double price,
    required bool isActive,
  });
  Future<PaginatedResponse<ProductsEntity>> getProducts({
    int page = 1,
    int pageSize = 100,
  });

  Future<List<ProductCategoriesEntity>> getProductCategories();
  Future<ProductsEntity> updateProduct({
    required int id,
    required int categoryId,
    required String name,
    required String description,
    required double price,
    required bool isActive,
  });
  Future<ProductsEntity> deleteProduct({required int id});
}
