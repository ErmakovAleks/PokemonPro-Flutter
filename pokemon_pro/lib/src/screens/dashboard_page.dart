import 'package:flutter/material.dart';
import '/src/routes/detail_state.dart';
import '/src/widgets/dashboard_mosaic_tile.dart';
import '/src/widgets/dashboard_list_tile.dart';
import '/src/models/pokemon_list_model.dart';
import '/src/providers/dashboard_provider.dart';
import '/src/widgets/dashboard_search_bar.dart';
import '/src/constants/pokofonts.dart';
import '/src/constants/pokocolors.dart';
import '/src/constants/pokoimages.dart';
import '/src/routes/routes.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isList = true;
  String searchText = '';
  final provider = DashboardProvider();
  late final Future<List<PokemonModel>?> pokemonList;

  FutureBuilder pokemonTile(String name) {
    return FutureBuilder(
      future: provider.detail(name),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return _isList
              ? InkWell(
                  child: DashboardListTile(details: snapshot.data!),
                  onTap: () {
                    context.detail.value = snapshot.data;
                    context.pageState.value = ActivePage.detail;
                  },
                )
              : InkWell(
                  child: DashboardMosaicTile(details: snapshot.data!),
                  onTap: () {
                    context.detail.value = snapshot.data;
                    context.pageState.value = ActivePage.detail;
                  },
                );
        } else {
          return const Icon(Icons.error);
        }
      },
    );
  }

  void onUpdateSearch(String text) {
    setState(() {
      searchText = text;
    });
  }

  @override
  void initState() {
    pokemonList = provider.pokemonList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body:
          body(pokemonList: pokemonList, provider: provider, context: context),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: PokoColors.wildSand,
      leading: IconButton(
        onPressed: () => context.pageState.value = ActivePage.aboutUs,
        icon: SizedBox(
          width: 24,
          height: 24,
          child: Image.asset(PokoImages.logo),
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                _isList = !_isList;
              });
            },
            icon: SizedBox(
              width: 24,
              height: 24,
              child: _isList
                  ? Image.asset(PokoImages.collectionRepresentIcon)
                  : Image.asset(PokoImages.tableRepresentIcon),
            )),
      ],
      bottom: title(),
    );
  }

  PreferredSize title() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(52),
      child: Container(
        padding: const EdgeInsets.only(left: 30),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'All Pokemon',
            style: TextStyle(
                fontSize: 34,
                fontFamily: PokoFonts.jakartaSans,
                fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }

  Widget sliverAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: true,
      snap: true,
      backgroundColor: PokoColors.wildSand,
      flexibleSpace: FlexibleSpaceBar(
        title: DashboardSearchBar(
          onUpdateSearch: (text) => onUpdateSearch(text),
        ),
        titlePadding: EdgeInsets.zero,
      ),
    );
  }

  Widget body(
      {required Future<List<PokemonModel>?> pokemonList,
      required DashboardProvider provider,
      required BuildContext context}) {
    return FutureBuilder(
      future: pokemonList,
      builder: (context, snapshot) {
        Widget pokemonSliver;
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.hasData) {
          List<PokemonModel>? filtered = snapshot.data
              ?.where((element) => element.name.contains(searchText))
              .toList();
          if (_isList) {
            pokemonSliver = SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return pokemonTile(filtered?[index].name ?? '');
              }),
              itemExtent: 143,
            );
          } else {
            pokemonSliver = SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return pokemonTile(filtered?[index].name ?? '');
                }),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 9,
                    mainAxisSpacing: 9,
                    mainAxisExtent: 199),
              ),
            );
          }
        } else {
          pokemonSliver = const SliverToBoxAdapter(child: Icon(Icons.error));
        }

        return Container(
          color: PokoColors.wildSand,
          child: CustomScrollView(
            slivers: [
              sliverAppBar(),
              SliverToBoxAdapter(
                child: Container(
                  height: 8,
                  color: PokoColors.wildSand,
                ),
              ),
              pokemonSliver
            ],
          ),
        );
      },
    );
  }
}
