import 'package:nativus_pos_desktop/features/products/domain/entities/product_categories_entity.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/products_entity.dart';

class ProductCategoryFilterHelper {
  static List<ProductCategoriesEntity> registeredCategories({
    required List<ProductCategoriesEntity> categories,
    required List<ProductsEntity> products,
  }) {
    final categoryIdsWithProducts = products
        .map((product) => product.categoryId)
        .whereType<int>()
        .toSet();

    if (categoryIdsWithProducts.isEmpty) {
      return const <ProductCategoriesEntity>[];
    }

    return categories
        .where((category) => categoryIdsWithProducts.contains(category.id))
        .toList();
  }
}
