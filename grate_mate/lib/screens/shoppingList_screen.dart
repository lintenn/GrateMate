import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tuple/tuple.dart';
import 'package:grate_mate/global_information/global_ingredients.dart'
    as globalIngredients;
import 'package:grate_mate/global_information/global_users.dart' as Users;

import '../global_information/colors_palette.dart';
import '../models/ingredient.dart';
import '../widgets/mate_text_h1.dart';
import '../widgets/mate_text_h3.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final List<Tuple2<Ingredient, int>> shoppingList = [
    Tuple2<Ingredient, int>(globalIngredients.bacon, 2),
    Tuple2<Ingredient, int>(globalIngredients.cheese, 30),
    Tuple2<Ingredient, int>(globalIngredients.carrot, 30)
  ];

  List<bool> isExpanded = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: GrateMate.grayGrateMate,
        body: Container(
          //TODO Even though we have 20 margin the cards have more space on the sides. why?
          margin: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: const MateTextH1(
                  text: 'Shopping List',
                ),
              ),
              Users.isLogged
                  ? Users.userLogged.shoppingList.isEmpty
                      ? const MateTextH3.normal(
                          text:
                              'Your shopping list is empty. Go to a recipe to add some ingredients!',
                        )
                      : Flexible(
                          child: ListView.builder(
                              itemCount: Users.userLogged.shoppingList.length,
                              itemBuilder: (context, index) {
                                return buildIngredientCard(
                                  Users.userLogged.shoppingList[index],
                                  index,
                                );
                              }),
                        )
                  : const MateTextH3.normal(
                      text: 'Log in to have a shopping list',
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIngredientCard(Tuple2<Ingredient, int> ingredient, int index) {
    isExpanded.add(false);
    return Card(
      child: InkWell(
        onTap: () {
          setState(() {
            isExpanded[index] = !isExpanded[index];
          });
        },
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      FaIcon(
                        ingredient.item1.icon.icon,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MateTextH3.normal(
                        text: ingredient.item1.name,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MateTextH3.normal(
                    text: '${ingredient.item2} ${ingredient.item1.unit}',
                  ),
                ),
              ],
            ),
            isExpanded[index]
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        print("delete ${index}");
                        setState(() {
                          Users.userLogged.shoppingList.remove(ingredient);
                          isExpanded = [];
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      child: const Text('Remove'),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
