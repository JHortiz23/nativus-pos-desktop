import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nativus_pos_desktop/core/enums/requests_anums.dart';
import 'package:nativus_pos_desktop/core/shared/data/models/paginated_response.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/products_entity.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_area_entity.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/table_summary_entity.dart';
import 'package:nativus_pos_desktop/features/tables/domain/use_cases/get_dining_areas_use_case.dart';

part 'tables_event.dart';
part 'tables_state.dart';

class TablesBloc extends Bloc<TablesEvent, TablesState> {
  // final AddProductUseCase addProductUseCase;
  // final GetProductsUseCase getProductsUseCase;
  final GetDiningAreasUseCase getDiningAreasUseCase;
  // final UpdateProductUseCase updateProductUseCase;
  // final DeleteProductUseCase deleteProductUseCase;

  TablesBloc({
    // required this.addProductUseCase,
    // required this.getProductsUseCase,
    required this.getDiningAreasUseCase,
    // required this.updateProductUseCase,
    // required this.deleteProductUseCase,
  }) : super(const TablesState()) {
    // on<AddProductEvent>(_onAddProduct);
    // on<GetProductsEvent>(_onGetProducts);
    on<GetDiningAreasEvent>(_onGetDiningAreas);
    // on<UpdateProductEvent>(_onUpdateProduct);
    // on<DeleteProductEvent>(_onDeleteProduct);
  }

  // Future<void> _onAddProduct(
  //   AddProductEvent event,
  //   Emitter<ProductsState> emit,
  // ) async {
  //   emit(
  //     AddingProduct(
  //       products: state.products,
  //       productCategories: state.productCategories,
  //       page: state.page,
  //       pageSize: state.pageSize,
  //     ),
  //   );

  //   try {
  //     await addProductUseCase(
  //       categoryId: event.categoryId,
  //       name: event.name,
  //       description: event.description,
  //       price: event.price,
  //       isActive: event.isActive,
  //     );

  //     emit(
  //       ProductAdded(
  //         products: state.products,
  //         productCategories: state.productCategories,
  //         page: state.page,
  //         pageSize: state.pageSize,
  //       ),
  //     );
  //     // emit a state to trigger products refresh after adding a product
  //     add(GetProductsEvent(page: state.page, pageSize: state.pageSize));
  //   } catch (e) {
  //     emit(
  //       ProductError(
  //         errorMessage: e.toString(),
  //         products: state.products,
  //         productCategories: state.productCategories,
  //         page: state.page,
  //         pageSize: state.pageSize,
  //       ),
  //     );
  //   }
  // }

  // Future<void> _onGetProducts(
  //   GetProductsEvent event,
  //   Emitter<ProductsState> emit,
  // ) async {
  //   emit(
  //     state.copyWith(
  //       isLoading: true,
  //       errorMessage: '',
  //       getProductsRequest: RequestsEnum.loading,
  //     ),
  //   );

  //   // Determine values to use (prefer event arguments, fallback to state defaults/current)
  //   final pageSize = event.pageSize > 0 ? event.pageSize : state.pageSize;
  //   final page = event.page > 0 ? event.page : state.page;

  //   try {
  //     final productsResponse = await getProductsUseCase(
  //       page: page,
  //       pageSize: pageSize,
  //     );

  //     emit(
  //       state.copyWith(
  //         products: productsResponse,
  //         page: page,
  //         pageSize: pageSize,
  //         getProductsRequest: RequestsEnum.success,
  //         isLoading: false,
  //         errorMessage: '',
  //       ),
  //     );
  //   } catch (e) {
  //     emit(
  //       state.copyWith(
  //         errorMessage: e.toString(),
  //         isLoading: false,
  //         getProductsRequest: RequestsEnum.failure,
  //       ),
  //     );
  //   }
  // }

  Future<void> _onGetDiningAreas(
    GetDiningAreasEvent event,
    Emitter<TablesState> emit,
  ) async {
    emit(
      LoadingDiningAreas(
        diningAreas: state.diningAreas,
        summary: state.summary,
        isLoading: true,
        errorMessage: '',
        page: state.page,
        pageSize: state.pageSize,
      ),
    );

    try {
      final tablesResponse = await getDiningAreasUseCase();

      emit(
        DiningAreasLoaded(
          diningAreas: tablesResponse.diningAreas,
          summary: tablesResponse.summary,
          isLoading: false,
          errorMessage: '',
          page: state.page,
          pageSize: state.pageSize,
        ),
      );
    } catch (e) {
      emit(
        TablesError(
          errorMessage: e.toString(),
          diningAreas: state.diningAreas,
          summary: state.summary,
          isLoading: false,
          page: state.page,
          pageSize: state.pageSize,
        ),
      );
    }
  }

  // Future<void> _onUpdateProduct(
  //   UpdateProductEvent event,
  //   Emitter<ProductsState> emit,
  // ) async {
  //   emit(
  //     UpdatingProduct(
  //       products: state.products,
  //       productCategories: state.productCategories,
  //       page: state.page,
  //       pageSize: state.pageSize,
  //     ),
  //   );

  //   try {
  //     await updateProductUseCase(
  //       id: event.id,
  //       categoryId: event.categoryId,
  //       name: event.name,
  //       description: event.description,
  //       price: event.price,
  //       isActive: event.isActive,
  //     );

  //     emit(
  //       ProductUpdated(
  //         products: state.products,
  //         productCategories: state.productCategories,
  //         page: state.page,
  //         pageSize: state.pageSize,
  //       ),
  //     );
  //     // emit a state to trigger products refresh after updating a product
  //     add(GetProductsEvent(page: state.page, pageSize: state.pageSize));
  //   } catch (e) {
  //     emit(
  //       ProductError(
  //         errorMessage: e.toString(),
  //         products: state.products,
  //         productCategories: state.productCategories,
  //         page: state.page,
  //         pageSize: state.pageSize,
  //       ),
  //     );
  //   }
  // }

  // Future<void> _onDeleteProduct(
  //   DeleteProductEvent event,
  //   Emitter<ProductsState> emit,
  // ) async {
  //   emit(
  //     DeletingProduct(
  //       products: state.products,
  //       productCategories: state.productCategories,
  //       page: state.page,
  //       pageSize: state.pageSize,
  //     ),
  //   );

  //   try {
  //     await deleteProductUseCase(id: event.id);
  //     emit(
  //       ProductDeleted(
  //         products: state.products,
  //         productCategories: state.productCategories,
  //         page: state.page,
  //         pageSize: state.pageSize,
  //       ),
  //     );
  //     // emit a state to trigger products refresh after deleting a product
  //     add(GetProductsEvent(page: state.page, pageSize: state.pageSize));
  //   } catch (e) {
  //     emit(
  //       ProductError(
  //         errorMessage: e.toString(),
  //         products: state.products,
  //         productCategories: state.productCategories,
  //         page: state.page,
  //         pageSize: state.pageSize,
  //       ),
  //     );
  //   }
  // }
}
