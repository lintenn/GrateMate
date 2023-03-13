library recipes;

import 'package:grate_mate/models/recipe.dart';
import 'package:grate_mate/global_information/global_ingredients.dart' as globalIngredients;
import 'package:tuple/tuple.dart';

import 'package:grate_mate/models/ingredient.dart';


List<Recipe> recipes = [
  Recipe(name: "Crepes",
      description: "Original french dessert",
      steps: [
        "Whisk the flour and eggs.",
        "Gradually add the milk and water.",
        "Scoop the batter onto a hot griddle.",
        "Cook until lightly browned on the bottom.",
        "Flip and continue cooking until done on both sides.",
      ],
      difficulty: 1,
      time: 30,
      imageURL: 'assets/crepes.jpg',
      ingredients: [
        Tuple2<Ingredient, int>(globalIngredients.flour, 250),
        Tuple2<Ingredient, int>(globalIngredients.eggs, 2),
        Tuple2<Ingredient, int>(globalIngredients.milk, 250)
      ]),
  Recipe(name: "burger",
      description: "Real texas burger",
      steps: ["Prepare ingredients", "Finish recipe"],
      difficulty: 3,
      time: 60,
      imageURL: 'assets/burger.png',
      ingredients: [
        Tuple2<Ingredient, int>(globalIngredients.bread, 2),
        Tuple2<Ingredient, int>(globalIngredients.cheese, 30),
        Tuple2<Ingredient, int>(globalIngredients.bacon, 2),
        Tuple2<Ingredient, int>(globalIngredients.salad, 20),
        Tuple2<Ingredient, int>(globalIngredients.meat, 1)
      ]),
  Recipe(name: "Tortilla",
      description: "Tipical spanish tortilla",
      steps: ["Prepare ingredients", "Do the dish"],
      difficulty: 5,
      time: 30,
      imageURL: 'assets/tortilla.png',
      ingredients: [
        Tuple2<Ingredient, int>(globalIngredients.eggs, 4),
        Tuple2<Ingredient, int>(globalIngredients.potato, 500),
        Tuple2<Ingredient, int>(globalIngredients.oil, 1),
        Tuple2<Ingredient, int>(globalIngredients.salt, 10),
      ]),
];