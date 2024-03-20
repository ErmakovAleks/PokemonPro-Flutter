import 'package:flutter/material.dart';
import 'package:pokemon_pro/src/models/pokemon_detail.dart';
import '/src/models/pokemon_list_model.dart';
import '../providers/dashboard_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = DashboardProvider();
    final pokemonList = provider.pokemonList();

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: pokemonList,
          builder: (BuildContext context,
              AsyncSnapshot<List<PokemonModel>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Индикатор загрузки
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemExtent: 300,
                itemBuilder: (context, index) {
                  // return Text(snapshot.data?[index].name ?? '');
                  return FutureBuilder(
                    future: provider.detail(snapshot.data?[index].name ?? ''),
                    builder: (BuildContext context,
                        AsyncSnapshot<PokemonDetail> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(); // Индикатор загрузки
                      } else if (snapshot.hasError) {
                        return Container(
                          height: 300,
                          child: const Icon(
                              Icons.error), //Text('Error: ${snapshot.error}'),
                        );
                      } else if (snapshot.hasData) {
                        return Container(
                          height: 300,
                          child: CachedNetworkImage(
                            imageUrl: '${snapshot.data?.sprite}',
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        );
                      } else {
                        return Text('No data');
                      }
                    },
                  );
                },
              );
            } else {
              return Text('No data');
            }
          }),
    );
  }
}
