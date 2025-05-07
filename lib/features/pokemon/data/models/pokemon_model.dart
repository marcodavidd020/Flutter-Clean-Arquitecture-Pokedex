import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/stat.dart';

class PokemonModel extends Pokemon {
  const PokemonModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.types,
    required super.height,
    required super.weight,
    required super.stats,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'],
      name: json['name'],
      imageUrl:
          json['sprites']['other']['official-artwork']['front_default'] ??
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${json['id']}.png',
      types:
          (json['types'] as List)
              .map((type) => type['type']['name'] as String)
              .toList(),
      height: json['height'],
      weight: json['weight'],
      stats:
          (json['stats'] as List)
              .map((stat) => StatModel.fromJson(stat))
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
      'stats': (stats as List<StatModel>).map((stat) => stat.toJson()).toList(),
    };
  }
}

class StatModel extends Stat {
  const StatModel({required super.name, required super.value});

  factory StatModel.fromJson(Map<String, dynamic> json) {
    return StatModel(
      name: json['stat']['name'],
      value: json['base_stat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'base_stat': value};
  }
}
