import 'package:grate_mate/models/recipe.dart';
import 'package:tuple/tuple.dart';

import 'ingredient.dart';

class User {
  int id;
  String firstName;
  String lastName;
  String username;
  String email;
  String password;
  String profilePhotoUrl;
  String phoneNumber;
  DateTime birthDate;
  List<Tuple2<Ingredient,int>> shoppingList;
  List<Recipe> bookmarks;

  User({
    required this.id,
    this.firstName = '',
    this.lastName = '',
    this.username = '',
    this.email = '',
    this.password = '',
    this.profilePhotoUrl = '',
    this.phoneNumber = '',
    DateTime? dateOfBirth,
  }) :shoppingList = [], bookmarks = [], birthDate = dateOfBirth ?? DateTime(0);


}
