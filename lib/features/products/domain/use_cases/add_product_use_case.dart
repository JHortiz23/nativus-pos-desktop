import 'package:nativus_pos_desktop/features/products/domain/entities/added_product_entity.dart';
import 'package:nativus_pos_desktop/features/products/domain/repositories/products_repository.dart';

class AddProductUseCase {
  final ProductsRepository productsRepository;

  AddProductUseCase({required this.productsRepository});

  Future<AddedProductEntity> call({
    required int categoryId,
    required String name,
    required String description,
    required double price,
    required bool isActive,
  }) {
    return productsRepository.addProduct(
      categoryId: categoryId,
      name: name,
      description: description,
      price: price,
      isActive: isActive,
    );
  }
}
