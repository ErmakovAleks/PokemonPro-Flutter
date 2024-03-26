import 'package:cached_network_image/cached_network_image.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:flutter/material.dart';
import '/src/constants/pokofonts.dart';
import '/src/constants/pokocolors.dart';
import '/src/widgets/dashboard_tag.dart';
import '/src/models/pokemon_detail.dart';

class DashboardMosaicTile extends StatelessWidget {
  final PokemonDetail details;
  const DashboardMosaicTile({required this.details, super.key});

  List<Widget> tags() {
    List<Widget> tags = [];
    for (var type in details.types) {
      tags.add(DashboardTag(type: type, option: TagOption.short));
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
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(50, 127, 127, 127),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '#${details.number.toString().padLeft(3, '0')}',
              style: const TextStyle(
                color: PokoColors.heather,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            height: 95,
            width: 95,
            child: Stack(
              children: [
                FutureBuilder(
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
                    }),
                CachedNetworkImage(
                  imageUrl: '${details.sprite}',
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            details.name,
            style: const TextStyle(
              fontFamily: PokoFonts.paytoneOne,
              fontSize: 19,
              color: PokoColors.abbey,
            ),
          ),
          const SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: tags()),
        ],
      ),
    );
  }
}
