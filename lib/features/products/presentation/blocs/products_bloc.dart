import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nativus_pos_desktop/core/enums/requests_anums.dart';
import 'package:nativus_pos_desktop/core/shared/data/models/paginated_response.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/product_categories_entity.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/products_entity.dart';
import 'package:nativus_pos_desktop/features/products/domain/use_cases/add_product_use_case.dart';
import 'package:nativus_pos_desktop/features/products/domain/use_cases/get_product_categories_use_case.dart';
import 'package:nativus_pos_desktop/features/products/domain/use_cases/get_products_use_case.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final AddProductUseCase addProductUseCase;
  final GetProductsUseCase getProductsUseCase;
  final GetProductCategoriesUseCase getProductCategoriesUseCase;

  ProductsBloc({
    required this.addProductUseCase,
    required this.getProductsUseCase,
    required this.getProductCategoriesUseCase,
  }) : super(const ProductsState()) {
    on<AddProductEvent>(_onAddProduct);
    on<GetProductsEvent>(_onGetProducts);
    on<GetProductCategoriesEvent>(_onGetProductCategories);
  }

  Future<void> _onAddProduct(
    AddProductEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(
      AddingProduct(
        products: state.products,
        productCategories: state.productCategories,
        page: state.page,
        pageSize: state.pageSize,
      ),
    );

    try {
      await addProductUseCase(
        categoryId: event.categoryId,
        name: event.name,
        description: event.description,
        price: event.price,
        isActive: event.isActive,
      );

      emit(
        ProductAdded(
          products: state.products,
          productCategories: state.productCategories,
          page: state.page,
          pageSize: state.pageSize,
        ),
      );
      // emit a state to trigger products refresh after adding a product
      add(GetProductsEvent(page: state.page, pageSize: state.pageSize));
    } catch (e) {
      emit(
        ProductError(
          errorMessage: e.toString(),
          products: state.products,
          productCategories: state.productCategories,
          page: state.page,
          pageSize: state.pageSize,
        ),
      );
    }
  }

  Future<void> _onGetProducts(
    GetProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: '',
        getProductsRequest: RequestsEnum.loading,
      ),
    );

    // Determine values to use (prefer event arguments, fallback to state defaults/current)
    final pageSize = event.pageSize > 0 ? event.pageSize : state.pageSize;
    final page = event.page > 0 ? event.page : state.page;

    try {
      final productsResponse = await getProductsUseCase(
        page: page,
        pageSize: pageSize,
      );

      emit(
        state.copyWith(
          products: productsResponse,
          page: page,
          pageSize: pageSize,
          getProductsRequest: RequestsEnum.success,
          isLoading: false,
          errorMessage: '',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          isLoading: false,
          getProductsRequest: RequestsEnum.failure,
        ),
      );
    }
  }

  Future<void> _onGetProductCategories(
    GetProductCategoriesEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    try {
      final productCategories = await getProductCategoriesUseCase();

      emit(
        state.copyWith(
          productCategories: productCategories,
          isLoading: false,
          errorMessage: '',
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }
}
