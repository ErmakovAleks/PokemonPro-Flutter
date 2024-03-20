class PokemonDetail {
  final int number;
  final String name;
  final List<PokeType> types;
  final List<Ability> abilities;
  final String weight;
  final String height;
  final Uri sprite;

  const PokemonDetail._({
    required this.number,
    required this.name,
    required this.types,
    required this.abilities,
    required this.weight,
    required this.height,
    required this.sprite,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail._(
      number: json['number'],
      name: json['name'],
      // types: (json['types'] as List)
      //     .map((item) => PokeType.fromString(item))
      //     .toList(),
      types: List<PokeType>.from(
          json["types"].map((item) => PokeType.fromString(item))),
      abilities: List<Ability>.from(
          json["abilities"].map((item) => Ability.fromJson(item))),
      weight: json['weight'],
      height: json['height'],
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
}
