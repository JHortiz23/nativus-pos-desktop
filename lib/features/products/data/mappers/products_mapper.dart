import 'package:nativus_pos_desktop/features/products/data/models/products_model.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/products_entity.dart';

class ProductsMapper {
  static ProductsEntity toEntity(ProductModel model) {
    return ProductsEntity(
      id: model.id,
      categoryId: model.categoryId,
      categoryName: model.categoryName,
      name: model.name,
      description: model.description,
      isActive: model.isActive,
      createdAt: model.createdAt,
      price: model.price,
    );
  }

  static ProductModel fromEntity(ProductsEntity entity) {
    return ProductModel(
      id: entity.id,
      categoryId: entity.categoryId,
      categoryName: entity.categoryName,
      name: entity.name,
      description: entity.description,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
      price: entity.price,
    );
  }
}
