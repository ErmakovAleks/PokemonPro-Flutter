import '../models/pokemon_detail.dart';
import '../models/pokemon_list_model.dart';

abstract class Source {
  Future<List<PokemonModel>?> pokemonList();

  Future<PokemonDetail> detail(String name);
}
