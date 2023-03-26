library categories;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grate_mate/models/category.dart';

Category vegetarian = Category(name: "Vegetarian", icon: const FaIcon(FontAwesomeIcons.leaf));
Category beef = Category(name: "Meat", icon: const FaIcon(FontAwesomeIcons.drumstickBite));
Category pasta = Category(name: "Pasta", icon: const FaIcon(FontAwesomeIcons.bowlFood));
Category desserts = Category(name: "Desserts", icon: const FaIcon(FontAwesomeIcons.cakeCandles));

List<Category> categories = [vegetarian, beef, pasta, desserts];