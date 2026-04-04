import 'package:nativus_pos_desktop/features/products/data/models/added_product_model.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/added_product_entity.dart';

class AddedProductMapper {
  static AddedProductEntity toEntity(AddedProductModel model) {
    return AddedProductEntity(
      id: model.id,
      restaurantId: model.restaurantId,
      categoryId: model.categoryId,
      name: model.name,
      description: model.description,
      price: model.price,
      isActive: model.isActive,
    );
  }

  static AddedProductModel fromEntity(AddedProductEntity entity) {
    return AddedProductModel(
      id: entity.id,
      restaurantId: entity.restaurantId,
      categoryId: entity.categoryId,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      isActive: entity.isActive,
    );
  }
}
