import 'package:cached_network_image/cached_network_image.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:flutter/material.dart';
import '../widgets/poke_spinner.dart';
import '../constants/pokocolors.dart';
import '../widgets/dashboard_tag.dart';
import '../models/pokemon_detail_model.dart';

class DashboardListTile extends StatelessWidget {
  final PokemonDetailModel details;

  const DashboardListTile({required this.details, super.key});

  List<Widget> tags() {
    List<Widget> tags = [];
    for (var type in details.types) {
      tags.add(DashboardTag(type: type, option: TagOption.full));
    }

    return tags;
  }

  Future<PaletteGenerator> _paletteGenerator() async {
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      Image.network('${details.sprite}').image,
    );
    return paletteGenerator;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _decoration(context),
        child: _tileContent(context),
      ),
    );
  }

  BoxDecoration _decoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : PokoColors.abbey,
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(50, 127, 127, 127),
          spreadRadius: 1,
          blurRadius: 4,
          offset: Offset(3, 3),
        ),
      ],
    );
  }

  Widget _tileContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _avatar(),
        const SizedBox(width: 16),
        _info(context),
      ],
    );
  }

  Widget _avatar() {
    return SizedBox(
      height: 95,
      width: 95,
      child: Stack(
        children: [
          _coloredBackground(),
          _roundedImage(),
        ],
      ),
    );
  }

  Widget _coloredBackground() {
    return FutureBuilder(
      future: _paletteGenerator(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(color: Colors.white);
        } else {
          return Container(
            decoration: BoxDecoration(
              color: snapshot.data?.colors.first.withAlpha(127),
              borderRadius: BorderRadius.circular(47.5),
            ),
          );
        }
      },
    );
  }

  Widget _roundedImage() {
    return CachedNetworkImage(
      imageUrl: '${details.sprite}',
      placeholder: (context, url) => const PokeSpinner(),
      maxWidthDiskCache: 300,
      maxHeightDiskCache: 300,
      fit: BoxFit.cover,
    );
  }

  Widget _info(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          details.name,
          style: Theme.of(context).primaryTextTheme.displayMedium,
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal, child: Row(children: tags())),
        Text(
          '#${details.number.toString().padLeft(3, '0')}',
          style: Theme.of(context).primaryTextTheme.headlineSmall,
        ),
      ],
    );
  }
}
