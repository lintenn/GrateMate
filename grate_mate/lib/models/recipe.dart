class Recipe {
  String name;
  String description;
  List<String> steps;
  int difficulty;
  int time;
  String imageURL;
  //TODO: List ingredients
  //TODO: Category

  Recipe(
      {required this.name,
        required this.description,
        required this.steps,
        required this.difficulty,
        required this.time,
        required this.imageURL});

}