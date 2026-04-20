import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nativus_pos_desktop/core/enums/requests_enums.dart';
import 'package:nativus_pos_desktop/core/shared/data/models/paginated_response.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/products_entity.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_area_entity.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_areas_summary_entity.dart';
import 'package:nativus_pos_desktop/features/tables/domain/use_cases/tables_use_cases_export.dart';

part 'tables_event.dart';
part 'tables_state.dart';

class TablesBloc extends Bloc<TablesEvent, TablesState> {
  final AddTableUseCase addTableUseCase;
  final GetDiningAreasUseCase getDiningAreasUseCase;
  final UpdateTableUseCase updateTableUseCase;
  final DeleteTableUseCase deleteTableUseCase;

  TablesBloc({
    required this.addTableUseCase,
    required this.getDiningAreasUseCase,
    required this.updateTableUseCase,
    required this.deleteTableUseCase,
  }) : super(const TablesState()) {
    on<AddTableEvent>(_onAddTable);
    on<GetDiningAreasEvent>(_onGetDiningAreas);
    on<UpdateTableEvent>(_onUpdateTable);
    on<DeleteTableEvent>(_onDeleteTable);
  }

  Future<void> _onAddTable(
    AddTableEvent event,
    Emitter<TablesState> emit,
  ) async {
    emit(
      AddingTable(
        diningAreas: state.diningAreas,
        summary: state.summary,
        isLoading: true,
        errorMessage: '',
        page: state.page,
        pageSize: state.pageSize,
      ),
    );

    try {
      await addTableUseCase(
        name: event.name,
        seats: event.seats,
        diningAreaId: event.diningAreaId,
        isActive: event.isActive,
      );

      emit(
        TableAdded(
          diningAreas: state.diningAreas,
          summary: state.summary,
          isLoading: false,
          errorMessage: '',
          page: state.page,
          pageSize: state.pageSize,
        ),
      );
      // emit a state to trigger dining areas refresh after adding a table
      add(GetDiningAreasEvent());
    } catch (e) {
      emit(
        TableError(
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
        TableError(
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

  Future<void> _onUpdateTable(
    UpdateTableEvent event,
    Emitter<TablesState> emit,
  ) async {
    emit(
      UpdatingTable(
        diningAreas: state.diningAreas,
        summary: state.summary,
        isLoading: true,
        errorMessage: '',
        page: state.page,
        pageSize: state.pageSize,
      ),
    );

    try {
      await updateTableUseCase(
        id: event.id,
        name: event.name,
        seats: event.seats,
        diningAreaId: event.diningAreaId,
        isActive: event.isActive,
      );

      emit(
        TableUpdated(
          diningAreas: state.diningAreas,
          summary: state.summary,
          isLoading: false,
          errorMessage: '',
          page: state.page,
          pageSize: state.pageSize,
        ),
      );
      // emit a state to trigger dining areas refresh after updating a table
      add(GetDiningAreasEvent());
    } catch (e) {
      emit(
        TableError(
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

  Future<void> _onDeleteTable(
    DeleteTableEvent event,
    Emitter<TablesState> emit,
  ) async {
    emit(
      DeletingTable(
        diningAreas: state.diningAreas,
        summary: state.summary,
        isLoading: true,
        errorMessage: '',
        page: state.page,
        pageSize: state.pageSize,
      ),
    );

    try {
      await deleteTableUseCase(id: event.id);
      emit(
        TableDeleted(
          diningAreas: state.diningAreas,
          summary: state.summary,
          isLoading: false,
          errorMessage: '',
          page: state.page,
          pageSize: state.pageSize,
        ),
      );
      // emit a state to trigger dining areas refresh after deleting a table
      add(GetDiningAreasEvent());
    } catch (e) {
      emit(
        TableError(
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
}
