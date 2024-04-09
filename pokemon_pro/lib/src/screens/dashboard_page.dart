import 'package:flutter/material.dart';
import '../routes/router.dart';
import '../widgets/poke_spinner.dart';
import '../providers/source.dart';
import '../widgets/dashboard_mosaic_tile.dart';
import '../widgets/dashboard_list_tile.dart';
import '../models/pokemon_list_model.dart';
import '../providers/dashboard_network_provider.dart';
import '../widgets/dashboard_search_bar.dart';
import '../constants/pokoimages.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isList = true;
  String _searchText = '';
  final Source _provider = DashboardNetworkProvider();
  late final Future<List<PokemonModel>?> _pokemonList;

  void _onUpdateSearch(String text) {
    setState(() {
      _searchText = text;
    });
  }

  @override
  void initState() {
    _pokemonList = _provider.pokemonList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(
        pokemonList: _pokemonList,
        provider: _provider,
        context: context,
      ),
    );
  }

  FutureBuilder _pokemonTile(String name) {
    return FutureBuilder(
      future: _provider.detail(name),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: PokeSpinner());
        } else if (snapshot.hasData) {
          return _isList ? _listTile(snapshot) : _mosaicTile(snapshot);
        } else if (snapshot.hasError) {
          print('<!> Error = ${snapshot.error.toString()}');
          return const Icon(Icons.error);
        } else {
          return const Icon(Icons.error);
        }
      },
    );
  }

  Widget _listTile(AsyncSnapshot<dynamic> snapshot) {
    return InkWell(
      child: DashboardListTile(
        details: snapshot.data!,
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRouteKeys.detail,
          arguments: snapshot.data,
        );
      },
    );
  }

  Widget _mosaicTile(AsyncSnapshot<dynamic> snapshot) {
    return InkWell(
      child: DashboardMosaicTile(
        details: snapshot.data!,
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRouteKeys.detail,
          arguments: snapshot.data,
        );
      },
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      leading: _leftButton(context),
      actions: [
        _rightButton(context),
      ],
      bottom: _title(),
    );
  }

  Widget _leftButton(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pushNamed(AppRouteKeys.aboutUs),
      icon: SizedBox(
        width: 24,
        height: 24,
        child: Image.asset(PokoImages.logo),
      ),
    );
  }

  Widget _rightButton(BuildContext context) {
    return IconButton(
      onPressed: () => setState(() {
        _isList = !_isList;
      }),
      icon: SizedBox(
        width: 24,
        height: 24,
        child: _isList
            ? Image.asset(PokoImages.collectionRepresentIcon)
            : Image.asset(PokoImages.tableRepresentIcon),
      ),
    );
  }

  PreferredSize _title() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(52),
      child: Container(
        padding: const EdgeInsets.only(left: 30),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'All Pokemon',
            style: Theme.of(context).primaryTextTheme.bodyLarge,
          ),
        ),
      ),
    );
  }

  Widget _sliverAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: true,
      snap: true,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      flexibleSpace: FlexibleSpaceBar(
        title: DashboardSearchBar(
          onUpdateSearch: (text) => _onUpdateSearch(text),
        ),
        titlePadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _body(
      {required Future<List<PokemonModel>?> pokemonList,
      required Source provider,
      required BuildContext context}) {
    return FutureBuilder(
      future: pokemonList,
      builder: (context, snapshot) {
        return Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: CustomScrollView(
            slivers: [
              _sliverAppBar(),
              SliverToBoxAdapter(
                child: Container(
                  height: 8,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
              _pokemonSliver(snapshot),
            ],
          ),
        );
      },
    );
  }

  Widget _pokemonSliver(AsyncSnapshot<List<PokemonModel>?> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting ||
        snapshot.hasData) {
      List<PokemonModel>? filtered = snapshot.data
          ?.where((element) => element.name.contains(_searchText))
          .toList();
      if (_isList) {
        return _sliverListLayout(filtered);
      } else {
        return _sliverGridLayout(filtered);
      }
    } else {
      return const SliverToBoxAdapter(child: Icon(Icons.error));
    }
  }

  Widget _sliverListLayout(List<PokemonModel>? filtered) {
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return _pokemonTile(filtered?[index].name ?? '');
        },
      ),
      itemExtent: 143,
    );
  }

  Widget _sliverGridLayout(List<PokemonModel>? filtered) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return _pokemonTile(
              filtered?[index].name ?? '',
            );
          },
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 9,
          mainAxisSpacing: 9,
          mainAxisExtent: 199,
        ),
      ),
    );
  }
}
