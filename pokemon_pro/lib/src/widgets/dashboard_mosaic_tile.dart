import 'package:cached_network_image/cached_network_image.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:flutter/material.dart';
import '/src/constants/pokocolors.dart';
import '/src/widgets/dashboard_tag.dart';
import '../models/pokemon_detail_model.dart';

class DashboardMosaicTile extends StatelessWidget {
  final PokemonDetailModel details;
  const DashboardMosaicTile({required this.details, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
      decoration: _decoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _serialNumber(context),
          _avatar(),
          const SizedBox(height: 4),
          _title(context),
          const SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: _tags()),
        ],
      ),
    );
  }

  Future<PaletteGenerator> _paletteGenerator() async {
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      Image.network('${details.sprite}').image,
    );
    return paletteGenerator;
  }

  String _toBondFormat(int number) {
    return '#${number.toString().padLeft(3, '0')}';
  }

  Widget _serialNumber(BuildContext context) {
    ThemeData styles = Theme.of(context);
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        _toBondFormat(details.number),
        style: styles.primaryTextTheme.headlineSmall,
      ),
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

  Widget _title(BuildContext context) {
    ThemeData styles = Theme.of(context);
    return Text(
      details.name,
      style: styles.primaryTextTheme.displaySmall,
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
      maxWidthDiskCache: 300,
      maxHeightDiskCache: 300,
      fit: BoxFit.cover,
    );
  }

  BoxDecoration _decoration(BuildContext context) {
    ThemeData styles = Theme.of(context);
    return BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: styles.brightness == Brightness.light
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

  List<Widget> _tags() {
    List<Widget> tags = [];
    for (var type in details.types) {
      tags.add(DashboardTag(type: type, option: TagOption.short));
    }

    return tags;
  }
}
