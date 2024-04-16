import 'package:async/async.dart';
import '../services/network_service/network_service_containable.dart';
import '../services/network_service/network_session_processable.dart';
import '../models/pokemon_detail_containable.dart';
import '../models/pokemon_list_containable.dart';
import '../models/pokemon_detail_model.dart';
import '../models/pokemon_list_model.dart';
import 'pokemon_network_source.dart';

class DashboardNetworkProvider extends NetworkServiceContainable
    implements PokemonNetworkSource {
  final NetworkSessionProcessable _networkService;
  int _offset = 0;

  DashboardNetworkProvider({required super.service})
      : _networkService = service;

  @override
  Future<List<PokemonModel>?> pokemonList() async {
    print('<!> offset = $_offset');
    Result<PokemonListModel> response = await _networkService
        .sendRequest(PokemonListContainable(limit: 10, offset: _offset));

    if (response.isValue) {
      _offset += 10;
      return response.asValue?.value.results;
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
