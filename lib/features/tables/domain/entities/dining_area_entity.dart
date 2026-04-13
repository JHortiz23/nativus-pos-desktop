import 'package:equatable/equatable.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/table_entity.dart';

class DiningAreaEntity extends Equatable {
  final int id;
  final String name;
  final bool isActive;
  final int tablesCount;
  final int availableCount;
  final int occupiedCount;
  final List<TableEntity> tables;

  const DiningAreaEntity({
    required this.id,
    required this.name,
    required this.isActive,
    required this.tablesCount,
    required this.availableCount,
    required this.occupiedCount,
    required this.tables,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        isActive,
        tablesCount,
        availableCount,
        occupiedCount,
        tables,
      ];

  DiningAreaEntity copyWith({
    int? id,
    String? name,
    bool? isActive,
    int? tablesCount,
    int? availableCount,
    int? occupiedCount,
    List<TableEntity>? tables,
  }) {
    return DiningAreaEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      tablesCount: tablesCount ?? this.tablesCount,
      availableCount: availableCount ?? this.availableCount,
      occupiedCount: occupiedCount ?? this.occupiedCount,
      tables: tables ?? this.tables,
    );
  }
}
