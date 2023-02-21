import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grate_mate/global_information/colors_palette.dart';
import 'package:grate_mate/models/ingredient.dart';
import 'package:tuple/tuple.dart';
import '../global_information/global_users.dart' as Users;


import '../models/recipe.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> with SingleTickerProviderStateMixin{
  TabController? _tabController;
  late int servings;


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
    Recipe recipe = ModalRoute.of(context)!.settings.arguments as Recipe;
    return Scaffold(
      //backgroundColor: GrateMate.grayGrateMate,
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
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              // Save recipe to bookmarks
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
                //TODO: change adding if there are more servings
                if(!Users.isLogged){
                  Navigator.pushReplacementNamed(context, '/home/login');
                }else{
                  recipe.ingredients.forEach((ingredient) {
                    if(Users.userLogged.shoppingList.contains(ingredient)){
                      int index = Users.userLogged.shoppingList.indexOf(ingredient);
                      Users.userLogged.shoppingList[index] = Tuple2<Ingredient,int>(Users.userLogged.shoppingList[index].item1,Users.userLogged.shoppingList[index].item2+ingredient.item2*servings);
                    }else{
                      Users.userLogged.shoppingList.add(ingredient);
                    }
                  });
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