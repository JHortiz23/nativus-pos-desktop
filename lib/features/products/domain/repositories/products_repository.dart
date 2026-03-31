import 'package:nativus_pos_desktop/core/shared/data/models/paginated_response.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/product_categories_entity.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/products_entity.dart';

abstract class ProductsRepository {
  Future<PaginatedResponse<ProductsEntity>> getProducts({
    int page = 1,
    int pageSize = 100,
  });

   Future<List<ProductCategoriesEntity>> getProductCategories();
}
