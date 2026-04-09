import 'package:equatable/equatable.dart';

class DiningAreaEntity extends Equatable {
  final int id;
  final String name;
  final bool isActive;

  const DiningAreaEntity({
    required this.id,
    required this.name,
    required this.isActive,
  });

  @override
  List<Object?> get props => [id, name, isActive];

  DiningAreaEntity copyWith({
    int? id,
    String? name,
    int? restaurantId,
    bool? isActive,
  }) {
    return DiningAreaEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
    );
  }
}
