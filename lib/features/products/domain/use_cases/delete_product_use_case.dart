import 'package:nativus_pos_desktop/features/products/domain/entities/products_entity.dart';
import 'package:nativus_pos_desktop/features/products/domain/repositories/products_repository.dart';

class DeleteProductUseCase {
  final ProductsRepository productsRepository;

  DeleteProductUseCase({required this.productsRepository});

  Future<ProductsEntity> call({required int id}) {
    return productsRepository.deleteProduct(id: id);
  }
}
