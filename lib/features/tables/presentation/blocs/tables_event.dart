part of 'tables_bloc.dart';

abstract class TablesEvent extends Equatable {
  const TablesEvent();

  @override
  List<Object?> get props => [];
}

/// Event to add a new table
class AddTableEvent extends TablesEvent {
  final String name;
  final int seats;
  final int diningAreaId;
  final bool isActive;

  const AddTableEvent({
    required this.name,
    required this.seats,
    required this.diningAreaId,
    required this.isActive,
  });

  @override
  List<Object?> get props => [name, seats, diningAreaId, isActive];
}

/// Event to get dining areas and their tables
class GetDiningAreasEvent extends TablesEvent {
  const GetDiningAreasEvent();

  @override
  List<Object?> get props => [];
}

/// Event to update an existing table
class UpdateTableEvent extends TablesEvent {
  final int id;
  final String name;
  final int seats;
  final int diningAreaId;
  final bool isActive;

  const UpdateTableEvent({
    required this.id,
    required this.name,
    required this.seats,
    required this.diningAreaId,
    required this.isActive,
  });

  @override
  List<Object?> get props => [id, name, seats, diningAreaId, isActive];
}

/// Event to delete a table
class DeleteTableEvent extends TablesEvent {
  final int id;

  const DeleteTableEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

/// Event to add a new dining area
class AddDiningAreaEvent extends TablesEvent {
  final String name;
  final bool isActive;
  final int tables;
  final String tableName;

  const AddDiningAreaEvent({
    required this.name,
    required this.isActive,
    required this.tables,
    required this.tableName,
  });

  @override
  List<Object?> get props => [name, isActive, tables, tableName];
}

/// Event to update an existing dining area
class UpdateDiningAreaEvent extends TablesEvent {
  final int id;
  final String name;
  final bool isActive;

  const UpdateDiningAreaEvent({
    required this.id,
    required this.name,
    required this.isActive,
  });

  @override
  List<Object?> get props => [id, name, isActive];
}

/// Event to delete a dining area
class DeleteDiningAreaEvent extends TablesEvent {
  final int id;

  const DeleteDiningAreaEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
