import 'package:nativus_pos_desktop/features/products/domain/entities/product_categories_entity.dart';
import 'package:nativus_pos_desktop/features/products/domain/repositories/products_repository.dart';

class GetProductCategoriesUseCase {
  final ProductsRepository productsRepository;

  GetProductCategoriesUseCase({required this.productsRepository});

  Future<List<ProductCategoriesEntity>> call() {
    return productsRepository.getProductCategories();
  }
}