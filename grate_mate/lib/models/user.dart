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
    this.firstName = '',
    this.lastName = '',
    this.username = '',
    this.email = '',
    this.password = '',
    this.profilePhotoUrl = '',
    this.phoneNumber = '',
    DateTime? dateOfBirth,
  }) :shoppingList = [], birthDate = dateOfBirth ?? DateTime(0);


}
