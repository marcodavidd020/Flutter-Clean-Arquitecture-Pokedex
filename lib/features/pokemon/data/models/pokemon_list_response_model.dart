import 'package:pokedex_application/features/pokemon/domain/entities/pokemon_list_response.dart';

class PokemonListResponseModel extends PokemonListResponse {
  const PokemonListResponseModel({
    required super.count,
    super.next,
    super.previous,
    required super.results,
  });

  factory PokemonListResponseModel.fromJson(Map<String, dynamic> json) {
    return PokemonListResponseModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results:
          (json['results'] as List)
              .map((item) => PokemonListItemModel.fromJson(item))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results':
          (results as List<PokemonListItemModel>)
              .map((item) => item.toJson())
              .toList(),
    };
  }
}

class PokemonListItemModel extends PokemonListItem {
  PokemonListItemModel({required super.name, required super.url});

  factory PokemonListItemModel.fromJson(Map<String, dynamic> json) {
    return PokemonListItemModel(name: json['name'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }
}
