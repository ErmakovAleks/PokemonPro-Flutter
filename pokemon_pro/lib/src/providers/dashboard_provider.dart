import 'package:http/http.dart' show Client;
import 'package:async/async.dart';
import 'package:pokemon_pro/src/models/pokemon_detail_containable.dart';
import '../models/pokemon_list_containable.dart';
import '../services/network_service/network_service.dart';
import '../models/pokemon_detail_model.dart';
import '../models/pokemon_list_model.dart';
import '../providers/source.dart';

const _root1 = 'https://pokeapi.co';
const _root2 = 'https://ex.traction.one';

class DashboardNetworkProvider implements Source {
  final Client client = Client();
  final NetworkService _networkService = NetworkService();

  @override
  Future<List<PokemonModel>?> pokemonList(
      {int limit = 20, int offset = 0}) async {
    Result<PokemonListModel> response = await _networkService
        .sendRequest(PokemonListContainable(limit: limit, offset: offset));

    if (response.isValue) {
      Result<PokemonListModel> fullResponse = await _networkService.sendRequest(
        PokemonListContainable(
            limit: response.asValue?.value.count ?? 0, offset: offset),
      );

      if (fullResponse.isValue) {
        return fullResponse.asValue?.value.results;
      } else {
        print(response.asError?.error.toString());
        return null;
      }
    } else {
      print(response.asError?.error.toString());
      return null;
    }
  }

  @override
  Future<PokemonDetailModel?> detail(String name) async {
    Result<PokemonDetailModel> response =
        await _networkService.sendRequest(PokemonDetailContainable(name));

    if (response.asValue != null) {
      return response.asValue?.value;
    } else {
      print(response.asError?.error.toString());
      return null;
    }
  }
}
