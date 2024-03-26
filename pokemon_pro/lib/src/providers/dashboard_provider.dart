import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../models/pokemon_detail.dart';
import '../models/pokemon_list_model.dart';
import '../providers/source.dart';

const _root1 = 'https://pokeapi.co';
const _root2 = 'https://ex.traction.one';

class DashboardProvider implements Source {
  final Client client = Client();

  @override
  Future<List<PokemonModel>?> pokemonList(
      {int limit = 20, int offset = 0}) async {
    Map<String, String> params = {'limit': '$limit', 'offset': '$offset'};
    final response = await client.get(
        Uri.parse('$_root1/api/v2/pokemon/').replace(queryParameters: params));
    final parsedJson = json.decode(response.body);
    final model = PokemonListModel.fromJson(parsedJson);

    params['limit'] = '${model.count}';
    final fullResponse = await client.get(
        Uri.parse('$_root1/api/v2/pokemon/').replace(queryParameters: params));
    final parsedFullJson = json.decode(fullResponse.body);
    final fullModel = PokemonListModel.fromJson(parsedFullJson);

    return fullModel.results;
  }

  Future<PokemonDetail> detail(String name) async {
    final response =
        await client.get(Uri.parse('$_root2/pokedex/pokemon/$name'));
    final parsedJson = json.decode(response.body);

    return PokemonDetail.fromJson(parsedJson[0]);
  }
}
