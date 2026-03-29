import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nativus_pos_desktop/core/enums/requests_anums.dart';
import 'package:nativus_pos_desktop/core/shared/data/models/paginated_response.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/products_entity.dart';
import 'package:nativus_pos_desktop/features/products/domain/use_cases/get_products_use_case.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase getProductsUseCase;

  ProductsBloc({required this.getProductsUseCase})
    : super(const ProductsState()) {
    on<GetProductsEvent>(_onGetProducts);
  }

  Future<void> _onGetProducts(
    GetProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

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
          isLoading: false,
          errorMessage: '',
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }
}
