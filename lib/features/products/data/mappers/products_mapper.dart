import 'package:nativus_pos_desktop/features/products/data/models/products_model.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/products_entity.dart';

class ProductsMapper {
  static ProductsEntity toEntity(ProductsModel model) {
    return ProductsEntity(
      id: model.id,
      name: model.name,
      description: model.description,
      isActive: model.isActive,
      createdAt: model.createdAt,
      price: model.price,
    );
  }

  static ProductsModel fromEntity(ProductsEntity entity) {
    return ProductsModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
      price: entity.price,
    );
  }
}
