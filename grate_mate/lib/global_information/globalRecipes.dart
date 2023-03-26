library recipes;

import 'package:grate_mate/models/recipe.dart';
import 'package:grate_mate/global_information/global_ingredients.dart'
    as globalIngredients;
import 'package:grate_mate/global_information/global_categories.dart'
    as globalCategories;
import 'package:tuple/tuple.dart';

import 'package:grate_mate/models/ingredient.dart';

List<Recipe> recipes = [
  Recipe(
    name: "Crepes",
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
    ],
    category: globalCategories.desserts,
  ),
  Recipe(
    name: "Burger",
    description: "Real texas burger",
    steps: ["Cook the meat for 10 minutes.",
      "Cook the egg for a few minutes.",
      "Put the meat and the fried egg on the bun.",
      "Add the cheese, bacon and lettuce.",
      "Finally add the ketchup and mustard (optional) and the top bun."
    ],
    difficulty: 3,
    time: 60,
    imageURL: 'assets/burger.png',
    ingredients: [
      Tuple2<Ingredient, int>(globalIngredients.bread, 2),
      Tuple2<Ingredient, int>(globalIngredients.cheese, 30),
      Tuple2<Ingredient, int>(globalIngredients.bacon, 2),
      Tuple2<Ingredient, int>(globalIngredients.salad, 20),
      Tuple2<Ingredient, int>(globalIngredients.meat, 1),
      Tuple2<Ingredient, int>(globalIngredients.eggs, 1),
    ],
    category: globalCategories.meat,
  ),
  Recipe(
    name: "Tortilla",
    description: "Tipical spanish tortilla",
    steps: [
      "Chop the onion and the potatoes.",
      "Fry the onion and the potatoes.",
      "Add the eggs and the salt.",
      "Cook until the eggs are done."
    ],
    difficulty: 5,
    time: 30,
    imageURL: 'assets/tortilla.png',
    ingredients: [
      Tuple2<Ingredient, int>(globalIngredients.eggs, 4),
      Tuple2<Ingredient, int>(globalIngredients.potato, 500),
      Tuple2<Ingredient, int>(globalIngredients.oil, 1),
      Tuple2<Ingredient, int>(globalIngredients.salt, 10),
    ],
    category: globalCategories.vegetarian,
  ),
  Recipe(
    name: "Tomato Soup with Chicken broth",
    description: "Creamy tomato soup with chicken broth",
    steps: [
      "Cook onion and garlic in olive oil until softened.",
      "Add chopped tomatoes and chicken broth, then simmer for 20 minutes.",
      "Blend the soup until smooth.",
      "Stir in cream and heat until warm.",
      "Season with salt and pepper to taste.",
    ],
    difficulty: 2,
    time: 40,
    imageURL: 'assets/tomato_soup_chicken.jpg',
    ingredients: [
      Tuple2<Ingredient, int>(globalIngredients.tomato, 500),
      Tuple2<Ingredient, int>(globalIngredients.onion, 1),
      Tuple2<Ingredient, int>(globalIngredients.garlic, 2),
      Tuple2<Ingredient, int>(globalIngredients.chickenBroth, 500),
      Tuple2<Ingredient, int>(globalIngredients.cream, 100)
    ],
    category: globalCategories.meat,
  ),
  Recipe(
    name: "Tomato Soup",
    description: "Creamy tomato soup",
    steps: [
      "Cook onion and garlic in olive oil until softened.",
      "Add chopped tomatoes, then simmer for 20 minutes.",
      "Blend the soup until smooth.",
      "Stir in cream and heat until warm.",
      "Season with salt and pepper to taste.",
    ],
    difficulty: 2,
    time: 40,
    imageURL: 'assets/tomato_soup.jpg',
    ingredients: [
      Tuple2<Ingredient, int>(globalIngredients.tomato, 500),
      Tuple2<Ingredient, int>(globalIngredients.onion, 1),
      Tuple2<Ingredient, int>(globalIngredients.garlic, 2),
      Tuple2<Ingredient, int>(globalIngredients.cream, 100)
    ],
    category: globalCategories.vegetarian,
  ),
  Recipe(
    name: "Spaghetti Bolognese",
    description: "Classic Italian pasta dish",
    steps: [
      "Cook the spaghetti according to the package directions.",
      "Meanwhile, heat the olive oil in a large skillet.",
      "Add the onion, garlic, and ground beef and cook until browned.",
      "Add the tomatoes, tomato paste, and seasonings.",
      "Simmer for 20 minutes.",
      "Stir in the parsley and serve over the cooked spaghetti.",
    ],
    difficulty: 3,
    time: 60,
    imageURL: 'assets/spaghetti_bolognese.jpg',
    ingredients: [
      Tuple2<Ingredient, int>(globalIngredients.spaghetti, 500),
      Tuple2<Ingredient, int>(globalIngredients.onion, 1),
      Tuple2<Ingredient, int>(globalIngredients.garlic, 2),
      Tuple2<Ingredient, int>(globalIngredients.groundBeef, 500),
      Tuple2<Ingredient, int>(globalIngredients.tomato, 500),
      Tuple2<Ingredient, int>(globalIngredients.tomatoPaste, 100),
      Tuple2<Ingredient, int>(globalIngredients.parsley, 10)
    ],
    category: globalCategories.pasta,
  ),
  Recipe(name: "Chicken Parmesan",
    description: "Classic Italian dish",
    steps: [
      "Preheat oven to 190ºC (375°F).",
      "Season chicken with salt, pepper, and Italian seasoning.",
      "Dip chicken in beaten egg, then coat with bread crumbs.",
      "Fry chicken in hot oil until golden brown on both sides.",
      "Place chicken in baking dish, cover with tomato paste and cheese.",
      "Bake in preheated oven for 20-25 minutes.",
    ],
    difficulty: 3,
    time: 60,
    imageURL: 'assets/chicken_parmesan.jpg',
    ingredients: [
      Tuple2<Ingredient, int>(globalIngredients.chickenBreast, 4),
      Tuple2<Ingredient, int>(globalIngredients.eggs, 2),
      Tuple2<Ingredient, int>(globalIngredients.breadCrumbs, 1),
      Tuple2<Ingredient, int>(globalIngredients.tomatoPaste, 1),
      Tuple2<Ingredient, int>(globalIngredients.cheese, 100)
    ],
    category: globalCategories.meat,
  ),
];
