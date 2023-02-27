import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grate_mate/global_information/colors_palette.dart';
import 'package:grate_mate/models/ingredient.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:tuple/tuple.dart';
import '../global_information/global_users.dart' as Users;
import 'package:material_dialogs/material_dialogs.dart';


import '../models/recipe.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> with SingleTickerProviderStateMixin{
  TabController? _tabController;
  late int servings;
  bool _showAdvice = false;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    servings = 1;
  }

  void _incrementServings() {
    setState(() {
      servings++;
    });
  }

  void _decrementServings() {
    setState(() {
      if (servings > 1) {
        servings--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        setState(() {
          _showAdvice=false;
        });
      },
    );

    // set up the AlertDialog
   /* AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );*/

    Recipe recipe = ModalRoute.of(context)!.settings.arguments as Recipe;
    return Scaffold(
      backgroundColor: GrateMate.grayGrateMate,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(recipe.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'MontserratBold',
            wordSpacing: 2,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Users.userLogged.bookmarks.contains(recipe) ? const Icon(Icons.bookmark) : const Icon(Icons.bookmark_border),
            onPressed: () {
              // Save recipe to bookmarks
              setState(() {
                if (Users.userLogged.bookmarks.contains(recipe)) {
                  Users.userLogged.bookmarks.remove(recipe);
                  Dialogs.bottomMaterialDialog(
                      msg: 'Recipe removed from bookmarks',
                      title: 'Success',
                      context: context,
                      actions: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                          child: IconsOutlineButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            text: 'Accept',
                            iconData: Icons.check_circle_outline,
                            textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            iconColor: Colors.white,
                            color: Color(0xff6cbf6c),
                          ),
                        ),
                      ]);
                } else {
                  Users.userLogged.bookmarks.add(recipe);
                  Dialogs.bottomMaterialDialog(
                      msg: 'Recipe added to bookmarks',
                      title: 'Success',
                      context: context,
                      actions: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                          child: IconsOutlineButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            text: 'Accept',
                            iconData: Icons.check_circle_outline,
                            textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            iconColor: Colors.white,
                            color: Color(0xff6cbf6c),
                          ),
                        ),
                      ]);
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(recipe.imageURL,
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                  ],
                ),
                // Now we add the "Cook with GrateMate" button over the image
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.only(top: 140),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.play_arrow),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(GrateMate.yellowNorthFace),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                        ),
                      ),
                      label: const Text('Start cooking',
                        style:
                        TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'MontserratMedium'
                        ),
                      ),
                      onPressed: () {
                        //TODO: start cooking the recipe
                        print('Cooking ${recipe.name}');
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 10.0,
                  right: 10.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.access_time),
                        const SizedBox(width: 5),
                        Text('${recipe.time} min'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 0),
            decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],

            ),
            child: TabBar(

              controller: _tabController,
              labelColor: Colors.black,
              tabs: const <Widget>[ // The tab texts should be in black
                Tab(
                  text: 'Ingredients',
                ),
                Tab(
                  text: 'Steps',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                getIngredientsTabWidget(recipe),
                getRecipeStepsTabWidget(recipe),
              ],
            ),
          ),

        ],
      ),

    );
  }

  Widget getIngredientsTabWidget(Recipe recipe) {

    return   SingleChildScrollView(
      child: Column(
        children: <Widget>[

          // Plus and minus buttons to modify the serving size
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: FloatingActionButton(
                    heroTag: 'removeBtn',
                    backgroundColor: GrateMate.yellowNorthFace,
                    onPressed: () {
                      _decrementServings();
                    },
                    child: const Icon(Icons.remove),

                  ),
                ),
                Text('Servings: $servings',
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: FloatingActionButton(
                    heroTag: 'addBtn',
                    backgroundColor: GrateMate.yellowNorthFace,
                    onPressed: () {
                      _incrementServings();
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(12),
            shrinkWrap: true,
            itemCount: recipe.ingredients.length,
            itemBuilder: (context, index) {
              return getIngredientCard(recipe.ingredients[index]);
            },
          ),
          const SizedBox(height: 50,),
          Center(
            child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(GrateMate.yellowNorthFace),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
              ),
              onPressed: () {
                if(!Users.isLogged){
                  Navigator.pushReplacementNamed(context, '/home/login');
                }else{
                  recipe.ingredients.forEach((ingredient) {
                    //In the recipe we have the ingredients (ist a tuple(Ingredient,quantity)) and also we have the class Ingredient
                    //With this code we check if in the shopping list we already have the Ingredient, without care about the quantity.
                    //If we have the ingredient => we return that ingredient (to be able in the next step to calculate the index)
                    //If not => We return the tuple(Ingredient, quantity: 0).
                    Tuple2<Ingredient,int> isContained = Users.userLogged.shoppingList.firstWhere((e) => e.item1 == ingredient.item1, orElse: () => Tuple2(ingredient.item1,0));
                    if(isContained.item2 != 0){
                      int index = Users.userLogged.shoppingList.indexOf(isContained);
                      Users.userLogged.shoppingList[index] = Tuple2(Users.userLogged.shoppingList[index].item1,Users.userLogged.shoppingList[index].item2+ingredient.item2*servings);
                    }else{
                      Users.userLogged.shoppingList.add(Tuple2(ingredient.item1, ingredient.item2*servings));
                    }
                  });
                }
                if(Users.isLogged){

                  Dialogs.bottomMaterialDialog(
                      msg: 'Ingredients added to shopping list.',
                      title: 'Success',
                      context: context,
                      actions: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                          child: IconsOutlineButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            text: 'Accept',
                            iconData: Icons.check_circle_outline,
                            textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            iconColor: Colors.white,
                            color: Color(0xff6cbf6c),
                          ),
                        ),
                      ]);
                }
              },
              icon: const Padding(
                padding: EdgeInsets.fromLTRB(8,8,0,8),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
              label: const Padding(
                padding: EdgeInsets.fromLTRB(0,8,8,8),
                child: Text(
                  'Add to shopping list',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40,),
        ],
      ),

    );
  }

  Widget getIngredientCard(Tuple2<Ingredient, int> ingredient) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
              children: <Widget>[
                FaIcon(ingredient.item1.icon.icon,
                  size: 30,
                ),
                const SizedBox(width: 8),
                Text('${ingredient.item1.name} ${ingredient.item2 * servings} ${ingredient.item1.unit}',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ]
          )
      ),
    );
  }


  Widget getRecipeStepsTabWidget(Recipe recipe) {
    return ListView(
      children: <Widget>[
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(12),
          shrinkWrap: true,
          itemCount: recipe.steps.length,
          itemBuilder: (context, index) {
            return getRecipeStepCard(recipe.steps[index], index);
          },
        ),


      ],
    );
  }

  Widget getRecipeStepCard(String step, int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            // We display the step number very fancy
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                backgroundColor: GrateMate.yellowNorthFace,
                child: Text('${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),

            Text(step,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

}