import 'package:flutter/material.dart';
import '/src/constants/pokoimages.dart';
import '/src/constants/pokocolors.dart';

class PokemonDetail {
  final int number;
  final String name;
  final List<PokeType> types;
  final List<Ability> abilities;
  final String weight;
  final String height;
  final Training training;
  final Uri sprite;

  const PokemonDetail._({
    required this.number,
    required this.name,
    required this.types,
    required this.abilities,
    required this.weight,
    required this.height,
    required this.training,
    required this.sprite,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail._(
      number: json['number'],
      name: json['name'],
      types: List<PokeType>.from(
          json["types"].map((item) => PokeType.fromString(item))),
      abilities: List<Ability>.from(
          json["abilities"].map((item) => Ability.fromJson(item))),
      weight: json['weight'],
      height: json['height'],
      training: Training.fromJson(json["training"]),
      sprite: Uri.parse(json['sprite']),
    );
  }
}

class Ability {
  final String name;
  final String description;
  final bool hidden;

  Ability._({
    required this.name,
    required this.description,
    required this.hidden,
  });

  factory Ability.fromJson(Map<String, dynamic> json) => Ability._(
        name: json["name"],
        description: json["description"],
        hidden: json["hidden"],
      );
}

class Training {
  String evYield;
  String catchRate;
  String baseFriendship;
  String baseExp;
  String growthRate;

  Training._({
    required this.evYield,
    required this.catchRate,
    required this.baseFriendship,
    required this.baseExp,
    required this.growthRate,
  });

  factory Training.fromJson(Map<String, dynamic> json) => Training._(
        evYield: json["evYield"],
        catchRate: json["catchRate"],
        baseFriendship: json["baseFriendship"],
        baseExp: json["baseExp"],
        growthRate: json["growthRate"],
      );
}

enum PokeType {
  fire('Fire'),
  grass('Grass'),
  electric('Electric'),
  water('Water'),
  flying('Flying'),
  poison('Poison'),
  bug('Bug'),
  ground('Ground'),
  fairy('Fairy'),
  normal('Normal'),
  steel('Steel'),
  fighting('Fighting'),
  rock('Rock'),
  ghost('Ghost'),
  psychic('Psychic'),
  ice('Ice'),
  dragon('Dragon'),
  dark('Dark');

  final String type;

  const PokeType(this.type);

  factory PokeType.fromString(String name) {
    return values.firstWhere((element) => element.type == name,
        orElse: () => throw Exception('<!> Invalid type'));
  }

  Color get tagColor {
    switch (this) {
      case PokeType.fire:
        return PokoColors.fire;
      case PokeType.grass:
        return PokoColors.grass;
      case PokeType.electric:
        return PokoColors.electric;
      case PokeType.water:
        return PokoColors.water;
      case PokeType.flying:
        return PokoColors.flying;
      case PokeType.poison:
        return PokoColors.poison;
      case PokeType.bug:
        return PokoColors.bug;
      case PokeType.ground:
        return PokoColors.ground;
      case PokeType.fairy:
        return PokoColors.fairy;
      case PokeType.normal:
        return PokoColors.normal;
      case PokeType.steel:
        return PokoColors.steel;
      case PokeType.fighting:
        return PokoColors.fighting;
      case PokeType.rock:
        return PokoColors.rock;
      case PokeType.ghost:
        return PokoColors.ghost;
      case PokeType.psychic:
        return PokoColors.psychic;
      case PokeType.ice:
        return PokoColors.ice;
      case PokeType.dragon:
        return PokoColors.dragon;
      case PokeType.dark:
        return PokoColors.dark;
    }
  }

  Color get tagFont {
    switch (this) {
      case PokeType.fire:
        return PokoColors.fireFont;
      case PokeType.grass:
        return PokoColors.grassFont;
      case PokeType.electric:
        return PokoColors.electricFont;
      case PokeType.water:
        return PokoColors.waterFont;
      case PokeType.flying:
        return PokoColors.flyingFont;
      case PokeType.poison:
        return PokoColors.poisonFont;
      case PokeType.bug:
        return PokoColors.bugFont;
      case PokeType.ground:
        return PokoColors.groundFont;
      case PokeType.fairy:
        return PokoColors.fairyFont;
      case PokeType.normal:
        return PokoColors.normalFont;
      case PokeType.steel:
        return PokoColors.steelFont;
      case PokeType.fighting:
        return PokoColors.fightingFont;
      case PokeType.rock:
        return PokoColors.rockFont;
      case PokeType.ghost:
        return PokoColors.ghostFont;
      case PokeType.psychic:
        return PokoColors.psychicFont;
      case PokeType.ice:
        return PokoColors.iceFont;
      case PokeType.dragon:
        return PokoColors.dragonFont;
      case PokeType.dark:
        return PokoColors.darkFont;
    }
  }

  Image get tagImage {
    switch (this) {
      case PokeType.fire:
        return Image.asset(PokoImages.fire);
      case PokeType.grass:
        return Image.asset(PokoImages.grass);
      case PokeType.electric:
        return Image.asset(PokoImages.electric);
      case PokeType.water:
        return Image.asset(PokoImages.water);
      case PokeType.flying:
        return Image.asset(PokoImages.flying);
      case PokeType.poison:
        return Image.asset(PokoImages.poison);
      case PokeType.bug:
        return Image.asset(PokoImages.bug);
      case PokeType.ground:
        return Image.asset(PokoImages.ground);
      case PokeType.fairy:
        return Image.asset(PokoImages.fairy);
      case PokeType.normal:
        return Image.asset(PokoImages.normal);
      case PokeType.steel:
        return Image.asset(PokoImages.steel);
      case PokeType.fighting:
        return Image.asset(PokoImages.fighting);
      case PokeType.rock:
        return Image.asset(PokoImages.rock);
      case PokeType.ghost:
        return Image.asset(PokoImages.ghost);
      case PokeType.psychic:
        return Image.asset(PokoImages.psychic);
      case PokeType.ice:
        return Image.asset(PokoImages.ice);
      case PokeType.dragon:
        return Image.asset(PokoImages.dragon);
      case PokeType.dark:
        return Image.asset(PokoImages.dark);
    }
  }
}
