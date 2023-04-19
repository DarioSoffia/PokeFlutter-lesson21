class Pokemon {
  final int id;
  final String name;
  final String urlSprite;
  final String urlImage;
  final double weight;
  final double height;
  final List<String> typesList;
  final List<String> moves;
  final Map<String, int> stats;

  Pokemon({
    required this.id,
    required this.name,
    required this.urlSprite,
    required this.urlImage,
    required this.weight,
    required this.height,
    required this.typesList,
    required this.moves,
    required this.stats,
  });

  Pokemon.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        urlSprite = json["sprites"]["front_default"],
        urlImage =
            json["sprites"]["other"]["official-artwork"]["front_default"],
        name = json["species"]["name"],
        weight = json["weight"].toDouble() / 10.0,
        height = json["height"].toDouble() * 10.0,
        typesList = getListTypesFromJson(json["types"]),
        moves = getMovesFromJson(json["moves"]),
        stats = getstatsFromJson(json);
}

Map<String, int> getstatsFromJson(Map<String, dynamic> json) {
  Map<String, int> finalMap = {};
  for (final stat in json["stats"]) {
    finalMap.putIfAbsent(stat["stat"]["name"], () => stat["base_stat"]);
  }
  return finalMap;
}

List<String> getListTypesFromJson(List<dynamic> json) {
  final List<String> typesList = [];
  for (var element in json) {
    typesList.add(element["type"]["name"]);
  }
  return typesList;
}

List<String> getMovesFromJson(List<dynamic> json) {
  final List<String> moves = [];
  for (var element in json) {
    moves.add(element["move"]["name"]);
  }
  return moves;
}
