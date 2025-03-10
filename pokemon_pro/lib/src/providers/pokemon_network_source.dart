import '../models/pokemon_detail_model.dart';
import '../models/pokemon_list_model.dart';

abstract class PokemonNetworkSource {
  Future<List<PokemonModel>?> pokemonList();

  Future<PokemonDetailModel?> detail(String name);
}
