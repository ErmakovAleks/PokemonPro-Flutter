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
  Color _backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _paletteGenerator('${widget.details.sprite}'),
      builder: (context, snapshot) {
        _backgroundColor = snapshot.data?.colors.first ?? _backgroundColor;

        return Scaffold(
          appBar: _appBar(),
          body: _body(),
        );
      },
    );
  }

  Future<PaletteGenerator> _paletteGenerator(String sprite) async {
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      Image.network(sprite).image,
    );
    return paletteGenerator;
  }

  String _toBondFormat(int number) {
    return '#${number.toString().padLeft(3, '0')}';
  }

  List<Widget> _tags() {
    List<Widget> tags = [];
    for (var type in widget.details.types) {
      tags.add(DashboardTag(type: type, option: TagOption.full));
    }

    return tags;
  }

  Widget _infoCell({required String name, required String? value}) {
    ThemeData styles = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 11.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value ?? '',
            style: styles.primaryTextTheme.headlineMedium,
          ),
          Text(
            name,
            style: styles.primaryTextTheme.headlineSmall,
          ),
        ],
      ),
    );
  }

  Widget _hashTagBlock(
      {required String title, required List<String> hashTags}) {
    List<Widget> hashTagsList = [];
    for (var tag in hashTags) {
      hashTagsList.add(_hashTag(tag));
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

  Widget _hashTag(String name) {
    ThemeData styles = Theme.of(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 8, 8),
      padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
      decoration: const BoxDecoration(
        color: PokoColors.heather,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(100),
          right: Radius.circular(100),
        ),
      ),
      child: Text(
        name,
        style: styles.primaryTextTheme.bodyMedium,
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    ThemeData styles = Theme.of(context);
    return AppBar(
      backgroundColor: _backgroundColor,
      title: const Text('Base experience'),
      titleTextStyle: styles.appBarTheme.titleTextStyle,
      leading: _leftButton(),
      actions: [_rightButton()],
    );
  }

  Widget _leftButton() {
    ThemeData styles = Theme.of(context);
    return IconButton(
      onPressed: () => Navigator.of(context).pushNamed(AppRouteKeys.dashboard),
      icon: SizedBox(
        width: 24,
        height: 24,
        child: Image.asset(
          PokoImages.back,
          color: styles.iconTheme.color,
        ),
      ),
    );
  }

  Widget _rightButton() {
    ThemeData styles = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Text(
        _toBondFormat(widget.details.number),
        style: styles.appBarTheme.titleTextStyle,
      ),
    );
  }

  Widget _body() {
    return Center(
      child: Container(
        color: _backgroundColor,
        child: SizedBox(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  _avatar(),
                  const SizedBox(height: 16),
                  _infoPanel(),
                ],
              ),
              _baseExperienceIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _antropometrics() {
    ThemeData styles = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.details.name,
          style: styles.primaryTextTheme.displayLarge,
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _tags(),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _infoCells(),
        ),
      ],
    );
  }

  List<Widget> _infoCells() {
    return [
      _infoCell(
        name: 'Height',
        value: widget.details.height.split(' (').first,
      ),
      Container(
        width: 1,
        height: 43,
        color: PokoColors.heather,
      ),
      _infoCell(
        name: 'Weight',
        value: widget.details.weight.split(' (').first,
      ),
      Container(
        width: 1,
        height: 43,
        color: PokoColors.heather,
      ),
      _infoCell(
        name: 'Species',
        value: 'Seed',
      ),
    ];
  }

  Widget _tagSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _hashTagBlock(
            title: 'Abilities',
            hashTags: ['Keen-eye', 'Tangle-feet', 'Big-pecks']),
        _hashTagBlock(title: 'Moves', hashTags: [
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

  Widget _avatar() {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
          color: Colors.white.withAlpha(80),
          borderRadius: BorderRadius.circular(150)),
      child: Stack(
        children: [
          _coloredBackground(),
          _roundedImage(),
          _experienceArcIndicator(),
        ],
      ),
    );
  }

  Widget _coloredBackground() {
    return Center(
      child: Container(
        height: 276,
        width: 276,
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(138),
        ),
      ),
    );
  }

  Widget _roundedImage() {
    return Center(
      child: Container(
        height: 262,
        width: 262,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(131),
        ),
        child: Image.network('${widget.details.sprite}'),
      ),
    );
  }

  Widget _experienceArcIndicator() {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: CustomPaint(
        painter: ArcPainter(
            baseExperience: int.parse(widget.details.training.baseExp)),
        size: const Size(294, 294),
      ),
    );
  }

  Widget _infoPanel() {
    ThemeData styles = Theme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          color: styles.colorScheme.primaryContainer,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _antropometrics(),
                const SizedBox(height: 24),
                _tagSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _baseExperienceIndicator() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 31,
        width: 31,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.5)),
          gradient: LinearGradient(
            colors: [PokoColors.gradientFinish, PokoColors.gradientStart],
          ),
        ),
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
}
