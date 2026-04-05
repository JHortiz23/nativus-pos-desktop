import 'package:nativus_pos_desktop/features/products/domain/entities/products_entity.dart';
import 'package:nativus_pos_desktop/features/products/domain/repositories/products_repository.dart';

class UpdateProductUseCase {
  final ProductsRepository productsRepository;

  UpdateProductUseCase({required this.productsRepository});

  Future<ProductsEntity> call({
    required int id,
    required int categoryId,
    required String name,
    required String description,
    required double price,
    required bool isActive,
  }) {
    return productsRepository.updateProduct(
      id: id,
      categoryId: categoryId,
      name: name,
      description: description,
      price: price,
      isActive: isActive,
    );
  }
}
