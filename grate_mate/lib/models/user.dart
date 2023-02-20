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

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.password,
    this.profilePhotoUrl = '',
    this.phoneNumber = '',
    required this.birthDate,
    required this.shoppingList,
  });


}
