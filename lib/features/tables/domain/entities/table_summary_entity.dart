import 'package:equatable/equatable.dart';

class TableSummaryEntity extends Equatable {
  final int totalTables;
  final int availableTables;
  final int occupiedTables;

  const TableSummaryEntity({
    required this.totalTables,
    required this.availableTables,
    required this.occupiedTables,
  });

  @override
  List<Object?> get props => [
        totalTables,
        availableTables,
        occupiedTables,
      ];

  TableSummaryEntity copyWith({
    int? totalTables,
    int? availableTables,
    int? occupiedTables,
  }) {
    return TableSummaryEntity(
      totalTables: totalTables ?? this.totalTables,
      availableTables: availableTables ?? this.availableTables,
      occupiedTables: occupiedTables ?? this.occupiedTables,
    );
  }
}
