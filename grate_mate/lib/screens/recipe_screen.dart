import 'package:flutter/material.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> with SingleTickerProviderStateMixin{
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Spaghetti Bolognese'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.bookmark),
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
                Center(
                  child: Image.network('https://staticfanpage.akamaized.net/wp-content/uploads/sites/22/2021/06/THUMB-LINK-2020-2-1200x675.jpg'),
                ),
                // Now we add the "Cook with GrateMate" button over the image
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(top: 160),
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.play_arrow),
                      label: Text('Cook with GrateMate'),
                      onPressed: () {
                        // Start cooking spaghetti bolognese
                        print('Cooking spaghetti bolognese');
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(top: 10, right: 10),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.timer),
                        SizedBox(height: 5),
                        Text('35 minutes'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: TabBar(
              controller: _tabController,
              tabs: <Widget>[ // The tab texts should be in black
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
                IngredientsTab(),
                RecipeStepsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IngredientsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[

          // Plus and minus buttons to modify the serving size
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: Icon(Icons.remove),
                  ),
                ),
                Text('Serving size: 2'),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ),

        // List of dummy ingredients with their images and quantities
        IngredientItem(
          ingredientName: 'Spaghetti',
          ingredientImage: 'assets/spaghetti.jpg',
          ingredientQuantity: '500g',
        ),
        IngredientItem(
          ingredientName: 'Tomato Sauce',
          ingredientImage: 'assets/tomato_sauce.jpg',
          ingredientQuantity: '1 can',
        ),
        IngredientItem(
          ingredientName: 'Onion',
          ingredientImage: 'assets/onion.jpg',
          ingredientQuantity: '1',
        ),
        IngredientItem(
          ingredientName: 'Garlic',
          ingredientImage: 'assets/garlic.jpg',
          ingredientQuantity: '2 cloves',
        ),
        IngredientItem(
          ingredientName: 'Beef',
          ingredientImage: 'assets/beef.jpg',
          ingredientQuantity: '500g',
        ),



        ],
    );
  }
}

Widget IngredientItem ({
  required String ingredientName,
  required String ingredientImage,
  required String ingredientQuantity,
}) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    child: Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10),
          child: Image.asset(ingredientImage, width: 50, height: 50),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(ingredientName),
            Text(ingredientQuantity),
          ],
        ),
      ],
    ),
  );

}



class RecipeStepsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
        // List of recipe steps with their images and descriptions
        RecipeStepItem(
          recipeStepImage: 'assets/step_1.jpg',
          recipeStepDescription: '1: Boil water in a pot',
        ),
        RecipeStepItem(
          recipeStepImage: 'assets/step_2.jpg',
          recipeStepDescription: '2: Add spaghetti to the pot',
        ),
        RecipeStepItem(
          recipeStepImage: 'assets/step_3.jpg',
          recipeStepDescription: '3: Add tomato sauce to the pot',
        ),
        RecipeStepItem(
          recipeStepImage: 'assets/step_4.jpg',
          recipeStepDescription: '4: Add onion and garlic to the pot',
        ),
        ],
    );
  }
}

Widget RecipeStepItem ({
  required String recipeStepImage,
  required String recipeStepDescription,
}) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    child: Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10),
          child: Image.asset(recipeStepImage, width: 50, height: 50),
        ),
        Text(recipeStepDescription),
      ],
    ),
  );

}