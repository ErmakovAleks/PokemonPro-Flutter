import 'package:palette_generator/palette_generator.dart';
import 'package:flutter/material.dart';
import '../models/pokemon_detail_model.dart';
import '../widgets/dashboard_tag.dart';
import '/src/constants/pokocolors.dart';
import '/src/constants/pokofonts.dart';
import '/src/widgets/arc_painter.dart';
import '/src/constants/pokoimages.dart';
import '../routes/router.dart';

class DetailPage extends StatefulWidget {
  final PokemonDetailModel details;

  const DetailPage({required this.details, super.key});

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

  List<Widget> tags() {
    List<Widget> tags = [];
    for (var type in widget.details.types) {
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
            style: Theme.of(context).primaryTextTheme.headlineMedium,
          ),
          Text(
            name,
            style: Theme.of(context).primaryTextTheme.headlineSmall,
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
        style: Theme.of(context).primaryTextTheme.bodyMedium,
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: const Text('Base experience'),
      titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
      leading: IconButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(AppRouteKeys.dashboard),
        icon: SizedBox(
          width: 24,
          height: 24,
          child: Image.asset(
            PokoImages.back,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Text(
            '#${widget.details.number.toString().padLeft(3, '0')}',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
      ],
    );
  }

  Widget antropometrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.details.name,
          style: Theme.of(context).primaryTextTheme.displayLarge,
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: tags(),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            infoCell(
                name: 'Height', value: widget.details.height.split(' (').first),
            Container(width: 1, height: 43, color: PokoColors.heather),
            infoCell(
                name: 'Weight', value: widget.details.weight.split(' (').first),
            Container(width: 1, height: 43, color: PokoColors.heather),
            infoCell(name: 'Species', value: 'Seed')
          ],
        ),
      ],
    );
  }

  Widget tagSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        hashTagBlock(
            title: 'Abilities',
            hashTags: ['Keen-eye', 'Tangle-feet', 'Big-pecks']),
        hashTagBlock(title: 'Moves', hashTags: [
          'Razor-wind',
          'Gust',
          'Fly',
          'Whirlwind',
          'Wing-attack',
          'Sand-attack'
        ]),
      ],
    );
  }

  Widget avatar() {
    return Container(
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
              child: Image.network('${widget.details.sprite}'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: CustomPaint(
              painter: ArcPainter(
                  baseExperience: int.parse(widget.details.training.baseExp)),
              size: const Size(294, 294),
            ),
          )
        ],
      ),
    );
  }

  Widget infoPanel() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                antropometrics(),
                const SizedBox(height: 24),
                tagSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget baseExperienceIndicator() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 31,
        width: 31,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.5)),
            gradient: LinearGradient(
                colors: [PokoColors.gradientFinish, PokoColors.gradientStart])),
        child: Center(
          child: Text(
            widget.details.training.baseExp,
            style: const TextStyle(
              fontFamily: PokoFonts.jakartaSans,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _paletteGenerator('${widget.details.sprite}'),
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
                        avatar(),
                        const SizedBox(height: 16),
                        infoPanel(),
                      ],
                    ),
                    baseExperienceIndicator(),
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
