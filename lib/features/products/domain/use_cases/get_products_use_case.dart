import 'package:nativus_pos_desktop/core/shared/data/models/paginated_response.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/products_entity.dart';
import 'package:nativus_pos_desktop/features/products/domain/repositories/products_repository.dart';

class GetProductsUseCase {
  final ProductsRepository productsRepository;

  GetProductsUseCase({required this.productsRepository});

  Future<PaginatedResponse<ProductsEntity>> call({
    int page = 1,
    int pageSize = 100,
  }) {
    return productsRepository.getProducts(page: page, pageSize: pageSize);
  }
}
