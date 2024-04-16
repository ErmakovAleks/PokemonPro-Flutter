import 'dart:async';

import 'package:flutter/material.dart';
import '../providers/inherited_provider_container.dart';
import '../routes/router.dart';
import '../widgets/poke_spinner.dart';
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
  bool _isLoading = false;
  final List<PokemonModel> _allPokemons = [];
  final StreamController<List<PokemonModel>?> _streamController =
      StreamController<List<PokemonModel>?>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _fetchData();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(
        context: context,
      ),
    );
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll >= maxScroll * 0.75 && !_isLoading) {
      _loadMoreData();
    }
  }

  void _loadMoreData() {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    _fetchData();

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _fetchData() async {
    final DashboardNetworkProvider provider =
        InheritedProviderContainer.of<DashboardNetworkProvider>(context)
            .provider;

    List<PokemonModel>? pokemonList = await provider.pokemonList();
    if (pokemonList != null) {
      _allPokemons.addAll(pokemonList);
      _streamController.sink.add(pokemonList);
    }
  }

  void _onUpdateSearch(String text) {
    setState(() {
      _searchText = text;
    });
  }

  FutureBuilder _pokemonTile({
    required String name,
    required DashboardNetworkProvider provider,
  }) {
    return FutureBuilder(
      future: provider.detail(name),
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
    ThemeData styles = Theme.of(context);
    return AppBar(
      backgroundColor: styles.appBarTheme.backgroundColor,
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
    ThemeData styles = Theme.of(context);
    return PreferredSize(
      preferredSize: const Size.fromHeight(52),
      child: Container(
        padding: const EdgeInsets.only(left: 30),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'All Pokemon',
            style: styles.primaryTextTheme.bodyLarge,
          ),
        ),
      ),
    );
  }

  Widget _sliverAppBar() {
    ThemeData styles = Theme.of(context);
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: true,
      snap: true,
      backgroundColor: styles.colorScheme.primaryContainer,
      flexibleSpace: FlexibleSpaceBar(
        title: DashboardSearchBar(
          onUpdateSearch: (text) => _onUpdateSearch(text),
        ),
        titlePadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _body({required BuildContext context}) {
    ThemeData styles = Theme.of(context);
    return StreamBuilder(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        return Container(
          color: styles.colorScheme.primaryContainer,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              _sliverAppBar(),
              SliverToBoxAdapter(
                child: Container(
                  height: 8,
                  color: styles.colorScheme.primaryContainer,
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
      // List<PokemonModel>? filtered = snapshot.data
      //     ?.where((element) => element.name.contains(_searchText))
      //     .toList();
      List<PokemonModel>? filtered = _allPokemons
          .where((element) => element.name.contains(_searchText))
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
        childCount: _allPokemons.length,
        (context, index) {
          return _pokemonTile(
            name: filtered?[index].name ?? '',
            provider:
                InheritedProviderContainer.of<DashboardNetworkProvider>(context)
                    .provider,
          );
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
          childCount: _allPokemons.length,
          (context, index) {
            return _pokemonTile(
              name: filtered?[index].name ?? '',
              provider: InheritedProviderContainer.of<DashboardNetworkProvider>(
                      context)
                  .provider,
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
