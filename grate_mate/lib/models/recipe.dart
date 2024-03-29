import 'package:tuple/tuple.dart';

import 'category.dart';
import 'ingredient.dart';

class Recipe {
  String name;
  String description;
  List<String> steps;
  int difficulty;
  int time;
  String imageURL;
  List<Tuple2<Ingredient, int>> ingredients;
  //TODO: Category
  Category category;

  Recipe(
      {required this.name,
        required this.description,
        required this.steps,
        required this.difficulty,
        required this.time,
        required this.imageURL,
        required this.ingredients,
        required this.category});

}