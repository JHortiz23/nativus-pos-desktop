import 'package:equatable/equatable.dart';

class TableEntity extends Equatable {
  final int id;
  final String name;
  final String status;
  final int? seats;

  const TableEntity({
    required this.id,
    required this.name,
    required this.status,
    this.seats,
  });

  @override
  List<Object?> get props => [id, name, status, seats];

  TableEntity copyWith({
    int? id,
    String? name,
    String? status,
    int? seats,
  }) {
    return TableEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      seats: seats ?? this.seats,
    );
  }
}
