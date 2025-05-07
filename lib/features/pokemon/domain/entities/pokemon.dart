import 'package:equatable/equatable.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/stat.dart';

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

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      types: List<String>.from(json['types'] as List),
      height: json['height'] as int,
      weight: json['weight'] as int,
      stats: (json['stats'] as List)
          .map((stat) => Stat.fromJson(stat as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'types': types,
      'height': height,
      'weight': weight,
      'stats': stats.map((stat) => stat.toJson()).toList(),
    };
  }

  factory Pokemon.empty() {
    return const Pokemon(
      id: 0,
      name: '',
      imageUrl: '',
      types: [],
      height: 0,
      weight: 0,
      stats: [],
    );
  }
}
