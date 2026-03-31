import 'package:nativus_pos_desktop/features/products/data/models/product_categories_model.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/product_categories_entity.dart';

class ProductCategoriesMapper {
  static ProductCategoriesEntity toEntity(ProductCategoriesModel model) {
    return ProductCategoriesEntity(
      id: model.id,
      name: model.name,
      isActive: model.isActive,
      isDeleted: model.isDeleted,
    );
  }

  static ProductCategoriesModel fromEntity(ProductCategoriesEntity entity) {
    return ProductCategoriesModel(
      id: entity.id,
      name: entity.name,
      isActive: entity.isActive,
      isDeleted: entity.isDeleted,
    );
  }
}
