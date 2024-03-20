import 'package:pokemon_pro/src/models/pokemon_list_model.dart';

abstract class Source {
  Future<List<PokemonModel>?> pokemonList();
}
