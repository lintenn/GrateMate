library recipes;

import 'package:grate_mate/models/recipe.dart';

final List<Recipe> recipes = [
  Recipe("Crepes", "Original french dessert",
      ["Prepare ingredients","Finish recipe"],
      3, 30,
      "../assets/crepes.jpg")
  ,
  Recipe("burger", "Real texas burger",
      ["Prepare ingredients","Finish recipe"],
      4, 60,
      "assets/crepes.jpg")
  ,
  Recipe("Tortilla", "Tipical spanish tortilla", ["Prepare ingredients","Do the dish"], 3, 30, "../assets/crepes.jpg")
];