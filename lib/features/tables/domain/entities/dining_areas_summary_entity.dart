import 'package:equatable/equatable.dart';

class DiningAreasSummaryEntity extends Equatable {
  final int totalTables;
  final int availableTables;
  final int occupiedTables;

  const DiningAreasSummaryEntity({
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

  DiningAreasSummaryEntity copyWith({
    int? totalTables,
    int? availableTables,
    int? occupiedTables,
  }) {
    return DiningAreasSummaryEntity(
      totalTables: totalTables ?? this.totalTables,
      availableTables: availableTables ?? this.availableTables,
      occupiedTables: occupiedTables ?? this.occupiedTables,
    );
  }
}
