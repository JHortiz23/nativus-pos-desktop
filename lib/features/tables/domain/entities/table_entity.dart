import 'package:equatable/equatable.dart';

class TableEntity extends Equatable {
  final int id;
  final int diningAreaId;
  final bool isActive;
  final String name;
  final String status;
  final int seats;

  const TableEntity({
    required this.id,
    required this.diningAreaId,
    required this.isActive,
    required this.name,
    required this.status,
    required this.seats,
  });

  @override
  List<Object?> get props => [id, diningAreaId, isActive, name, status, seats];

  TableEntity copyWith({
    int? id,
    int? diningAreaId,
    bool? isActive,
    String? name,
    String? status,
    int? seats,
  }) {
    return TableEntity(
      id: id ?? this.id,
      diningAreaId: diningAreaId ?? this.diningAreaId,
      isActive: isActive ?? this.isActive,
      name: name ?? this.name,
      status: status ?? this.status,
      seats: seats ?? this.seats,
    );
  }
}
