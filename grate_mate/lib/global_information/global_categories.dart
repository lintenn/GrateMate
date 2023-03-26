library categories;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grate_mate/models/category.dart';

//To add an icon go to: https://fontawesome.com/icons and search for the icon you want IT HAS TO BE FREE

Category vegetarian = Category(name: "Vegetarian", icon: const FaIcon(FontAwesomeIcons.leaf));
Category meat = Category(name: "Meat", icon: const FaIcon(FontAwesomeIcons.drumstickBite));
Category pasta = Category(name: "Pasta", icon: const FaIcon(FontAwesomeIcons.bowlFood));
Category desserts = Category(name: "Desserts", icon: const FaIcon(FontAwesomeIcons.cakeCandles));

List<Category> categories = [vegetarian, meat, pasta, desserts];