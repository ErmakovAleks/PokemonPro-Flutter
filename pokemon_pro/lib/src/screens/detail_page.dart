import 'package:palette_generator/palette_generator.dart';
import 'package:flutter/material.dart';
import '../models/pokemon_detail.dart';
import '../widgets/dashboard_tag.dart';
import '/src/constants/pokocolors.dart';
import '/src/constants/pokofonts.dart';
import '/src/widgets/arc_painter.dart';
import '/src/constants/pokoimages.dart';
import '/src/routes/detail_state.dart';
import '/src/routes/routes.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Color backgroundColor = Colors.white;

  Future<PaletteGenerator> _paletteGenerator(String sprite) async {
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      Image.network(sprite).image,
    );
    return paletteGenerator;
  }

  List<Widget> tags(List<PokeType> types) {
    List<Widget> tags = [];
    for (var type in types) {
      tags.add(DashboardTag(type: type, option: TagOption.full));
    }

    return tags;
  }

  Widget infoCell({required String name, required String? value}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 11.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value ?? '',
            style: const TextStyle(
              fontFamily: PokoFonts.jakartaSans,
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          Text(
            name,
            style: const TextStyle(
              fontFamily: PokoFonts.jakartaSans,
              fontSize: 12,
              color: PokoColors.heather,
            ),
          ),
        ],
      ),
    );
  }

  Widget hashTagBlock({required String title, required List<String> hashTags}) {
    List<Widget> hashTagsList = [];
    for (var tag in hashTags) {
      hashTagsList.add(hashTag(tag));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: PokoFonts.jakartaSans,
            fontSize: 15,
            color: PokoColors.heather,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(children: hashTagsList),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget hashTag(String name) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 8, 8),
      padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
      decoration: const BoxDecoration(
        color: PokoColors.heather,
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(100), right: Radius.circular(100)),
      ),
      child: Text(
        name,
        style: const TextStyle(
          fontFamily: PokoFonts.jakartaSans,
          fontSize: 15,
          color: PokoColors.abbey,
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: const Text('Base experience'),
      titleTextStyle: const TextStyle(
        fontSize: 19,
        color: Colors.white,
      ),
      leading: IconButton(
        onPressed: () => context.pageState.value = ActivePage.dashboard,
        icon: SizedBox(
          width: 24,
          height: 24,
          child: Image.asset(PokoImages.back, color: Colors.white),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Text(
            '#${context.detail.value?.number.toString().padLeft(3, '0')}',
            style: const TextStyle(
              fontFamily: PokoFonts.jakartaSans,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    PokemonDetail? detail = context.detail.value;

    return FutureBuilder(
      future: _paletteGenerator('${context.detail.value?.sprite}'),
      builder: (context, snapshot) {
        backgroundColor = snapshot.data?.colors.first ?? backgroundColor;

        return Scaffold(
          appBar: appBar(),
          body: Center(
            child: Container(
              color: backgroundColor,
              child: SizedBox(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                              color: Colors.white.withAlpha(80),
                              borderRadius: BorderRadius.circular(150)),
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  height: 276,
                                  width: 276,
                                  decoration: BoxDecoration(
                                    color: backgroundColor,
                                    borderRadius: BorderRadius.circular(138),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  height: 262,
                                  width: 262,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(131),
                                  ),
                                  child: Image.network('${detail?.sprite}'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6),
                                child: CustomPaint(
                                  painter: ArcPainter(
                                      baseExperience: int.parse(
                                          detail?.training.baseExp ?? '0')),
                                  size: const Size(294, 294),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24)),
                              color: Colors.white,
                            ),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      // здесь будут размещаться отцентрованные элементы
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${detail?.name}',
                                          style: const TextStyle(
                                            fontFamily: PokoFonts.paytoneOne,
                                            fontSize: 36,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: tags(detail?.types ?? []),
                                        ),
                                        const SizedBox(height: 24),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            infoCell(
                                                name: 'Height',
                                                value: detail?.height
                                                    .split(' (')
                                                    .first),
                                            Container(
                                                width: 1,
                                                height: 43,
                                                color: PokoColors.heather),
                                            infoCell(
                                                name: 'Weight',
                                                value: detail?.weight
                                                    .split(' (')
                                                    .first),
                                            Container(
                                                width: 1,
                                                height: 43,
                                                color: PokoColors.heather),
                                            infoCell(
                                                name: 'Species', value: 'Seed')
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        hashTagBlock(
                                            title: 'Abilities',
                                            hashTags: [
                                              'Keen-eye',
                                              'Tangle-feet',
                                              'Big-pecks'
                                            ]),
                                        hashTagBlock(title: 'Moves', hashTags: [
                                          'Razor-wind',
                                          'Gust',
                                          'Fly',
                                          'Whirlwind',
                                          'Wing-attack',
                                          'Sand-attack'
                                        ]),
                                      ],
                                    ), // здесь будут размещаться секции с тегами
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 31,
                        width: 31,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.5)),
                            gradient: LinearGradient(colors: [
                              PokoColors.gradientFinish,
                              PokoColors.gradientStart
                            ])),
                        child: Center(
                          child: Text(
                            context.detail.value?.training.baseExp ?? '',
                            style: const TextStyle(
                              fontFamily: PokoFonts.jakartaSans,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
