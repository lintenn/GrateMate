import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:grate_mate/global_information/global_ingredients.dart' as globalIngredients;
import '../global_information/colors_palette.dart';
import '../models/ingredient.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);



  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {

  final List<Tuple2<Ingredient,int>> shoppingList = [Tuple2<Ingredient,int>(globalIngredients.bacon, 2),
    Tuple2<Ingredient,int>(globalIngredients.cheese, 30),
    Tuple2<Ingredient,int>(globalIngredients.bacon, 2)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GrateMate.grayGrateMate,
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            children: [
              const SizedBox(height: 50,),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Text(
                  'Shopping List',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'MontserratExtraBold',
                    //color: GrateMate.darkGrateMate
                  ),
                ),
              ),
              ListView(
                /*itemCount: shoppingList.length,
                itemBuilder: (context, index){*/
                  children: buildingredientList(shoppingList),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildingredientList(List<Tuple2<Ingredient, int>> shoppingList) {
    return shoppingList.map((ingredient) {
       return buildIngredientCard(ingredient);
    }).toList();
  }

  Widget buildIngredientCard(Tuple2<Ingredient, int> ingredient) {
    bool isExpanded = false;

    return Card(
      child: InkWell(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ingredient.item1.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ingredient.item2 as String,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
            isExpanded?
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Remove'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
              ),
            )
                :
            const SizedBox.shrink(),
          ],
        ),
      ),
    );

  }
}
