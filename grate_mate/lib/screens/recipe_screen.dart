import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grate_mate/global_information/colors_palette.dart';
import 'package:grate_mate/models/ingredient.dart';
import 'package:tuple/tuple.dart';

import '../models/recipe.dart';

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
    final recipe = ModalRoute.of(context)!.settings.arguments as Recipe;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(recipe.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'RobotoBlack',
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
                        backgroundColor: MaterialStateProperty.all<Color>(GrateMate.greenGrateMate),
                      ),
                      label: const Text('Start cooking',
                        style:
                        TextStyle(
                            color: Colors.white,
                            fontSize: 20,
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
            margin: const EdgeInsets.only(top: 10),
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
    return  ListView(
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
                  backgroundColor: GrateMate.greenGrateMate,
                  //TODO: Define
                  onPressed: () {},
                  child: const Icon(Icons.remove),

                ),
              ),
              const Text('Serving size: 1'),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: FloatingActionButton(
                  heroTag: 'addBtn',
                  backgroundColor: GrateMate.greenGrateMate,
                  //TODO: Define
                  onPressed: () {},
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          padding: const EdgeInsets.all(12),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: recipe.ingredients.length,
          itemBuilder: (context, index) {
            return getIngredientCard(recipe.ingredients[index]);
          },
        ),
      ],
    );;
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
              Text('${ingredient.item1.name} ${ingredient.item2} ${ingredient.item1.unit}',
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
          padding: const EdgeInsets.all(12),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: recipe.steps.length,
          itemBuilder: (context, index) {
            return getRecipeStepCard(recipe.steps[index]);
          },
        ),
      ],
    );
  }

  Widget getRecipeStepCard(String step) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(step,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

}