import '../models/pokemon_detail_model.dart';
import '../services/network_service/url_containable.dart';

class PokemonDetailContainable extends URLContainable<PokemonDetailModel> {
  final String name;

  PokemonDetailContainable(this.name);

  @override
  Map<String, dynamic>? get body => null;

  @override
  PokemonDetailModel fromJson(Map<String, dynamic> json) {
    return PokemonDetailModel.fromJson(json);
  }

  @override
  Map<String, String>? get headers => null;

  @override
  Map<String, String>? get params => null;

  @override
  String get path => '/pokedex/pokemon/$name';
}
