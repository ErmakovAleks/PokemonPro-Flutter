class PokemonListModel {
  final int? count;
  final String? next;
  final String? previous;
  final List<PokemonModel>? results;

  PokemonListModel._({this.count, this.next, this.previous, this.results});

  factory PokemonListModel.fromJson(Map<String, dynamic> json) {
    return PokemonListModel._(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: json['results'] != null
          ? (json['results'] as List)
              .map((item) => PokemonModel.fromJson(item))
              .toList()
          : null,
    );
  }
}

class PokemonModel {
  final String name;
  final String url;

  PokemonModel._({required this.name, required this.url});

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel._(
      name: json['name'],
      url: json['url'],
    );
  }
}
