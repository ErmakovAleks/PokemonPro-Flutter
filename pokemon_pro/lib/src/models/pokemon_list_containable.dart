import '../models/pokemon_list_model.dart';
import '../services/network_service/url_containable.dart';

class PokemonListContainable extends URLContainable<PokemonListModel> {
  final int limit;
  final int offset;

  PokemonListContainable({required this.limit, required this.offset});

  @override
  String get host => 'pokeapi.co';

  @override
  String get path => '/api/v2/pokemon/';

  @override
  Map<String, String>? get headers => null;

  @override
  Map<String, dynamic>? get body => null;

  @override
  Map<String, String>? get params => {'limit': '$limit', 'offset': '$offset'};

  @override
  PokemonListModel fromJson(Map<String, dynamic> json) {
    return PokemonListModel.fromJson(json);
  }
}
