import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;
  final List<Stat> stats;

  const Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
    required this.stats,
  });

  @override
  List<Object> get props => [id, name, imageUrl, types, height, weight, stats];
}

class Stat extends Equatable {
  final String name;
  final int baseStat;

  const Stat({required this.name, required this.baseStat});

  @override
  List<Object> get props => [name, baseStat];
}
