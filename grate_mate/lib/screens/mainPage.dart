
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grate_mate/widgets/mate_error_text.dart';
import '../global_information//globalRecipes.dart' as globalRecipes;
import '../global_information/global_categories.dart' as globalCategories;
import 'dart:core';
import '../global_information/colors_palette.dart';
import '../models/recipe.dart';
import '../widgets/mate_text_h1.dart';
import '../widgets/mate_text_h2.dart';
import '../widgets/mate_text_h3.dart';
import '../widgets/mate_text_p.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _searchController = TextEditingController();
  bool _showError = false;
  bool _expandCategories = false;
  List<Recipe> recipes = globalRecipes.recipes;
  List<Recipe> recipesFiltered = globalRecipes.recipes;
  String filter = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: GrateMate.grayGrateMate,
        body: Container(
          margin: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: MateTextH1(
                  text: greetUser(),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 20, 10, 10),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                        offset: Offset(0.0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(25, 20, 0, 10),
                      hintText: 'Search',
                      hintStyle: const TextStyle(
                        fontFamily: 'MontSerrat',
                        fontSize: 14,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: _search,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              _showError
                  ? const Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                      child: MateTextError(
                        text: 'You have to enter a search term',
                      ),
                    )
                  : Container(),
              // Display a categories button

              ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    MateTextH2(
                      text: 'Categories',
                    ),
                    Icon(
                      this._expandCategories
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    _expandCategories = !_expandCategories;
                  });
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: GrateMate.earthYellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

              this._expandCategories ?
                // This must be scrollable, using the function _buildCategory
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: globalCategories.categories.length,
                    itemBuilder: (context, index) {
                      return _buildCategory(
                        text: globalCategories.categories[index].name,
                        icon: globalCategories.categories[index].icon,
                      );
                    },
                  ),
                )
              : Container(),

              Row(
                children: [
                  Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 10, 10),
                        child: MateTextH2(text: 'Last Recipes'),
                      ),
                    ],
                  ),
                ],
              ),
              Flexible(
                /*child: GridView.count(
                  crossAxisCount: 1,
                  scrollDirection: Axis.vertical,
                  children: globalRecipes.recipes.map((recipe) => recipeCard(recipe)).toList(),
                  ),*/
                child: !recipesFiltered.isEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        itemCount: recipesFiltered.length,
                        itemBuilder: (context, index) {
                          return recipeCard(recipesFiltered[index]);
                        },
                      )
                    : Row(
                        children: [
                          Flexible(
                            child: Column(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                                  child: Text(
                                    'No results found. Try another search term',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Montserrat',
                                      //color: GrateMate.darkGrateMate
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeFilter(String newFilter) {
    setState(() {
      if (filter == newFilter) {
        filter = '';
      } else {
        filter = newFilter;
      }

      if (filter == '') {
        recipesFiltered = recipes;
      } else {
        recipesFiltered =
            recipes.where((recipe) => recipe.category.name == filter).toList();
      }
    });
  }

  Widget _buildCategory({String text = 'Breakfast', required FaIcon icon}) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            decoration: BoxDecoration(
              color: filter == text ? GrateMate.earthYellow : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                  offset: const Offset(0.0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: icon,
              onPressed: () {
                _changeFilter(text);
              },
            ),
          ),
          MateTextH3.bold(
            text: text,
          ),
        ],
      ),
    );
  }

  void _search() {
    if (_searchController.text.isEmpty) {
      setState(() {
        _showError = true;
      });
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          _showError = false;
        });
      });
    } else {
      String searchValue = _searchController.text;
      print(searchValue);
      setState(() {
        recipesFiltered = recipes
            .where((recipe) =>
                recipe.name.toLowerCase().contains(searchValue.toLowerCase()))
            .toList();
      });
    }
  }

  Widget recipeCard(recipe) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/recipe', arguments: recipe);
        },
        child: Card(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                child: MateTextH3.bold(
                  text: recipe.name,
                ),
              ),
              AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(recipe.imageURL, fit: BoxFit.cover)),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                child: MateTextP(text: recipe.description),
              ),
              //This code create a bar instead of a rectangles
              /*Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 20, 8),
                child:  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: recipe.difficulty / 5,
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                          colors: _getDifficultyColors(recipe.difficulty),
                        ),
                      ),
                    )
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                child: getDfficultyBar(recipe.difficulty),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                child: Row(
                  children: [
                    Icon(Icons.access_time),
                    SizedBox(width: 5),
                    MateTextP(text: "${recipe.time} min"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getDfficultyBar(int difficulty) {
    return Row(
      children: List.generate(
        difficulty,
        (index) => Container(
          width: 30,
          height: 15,
          margin: EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            color: _getDifficultyColors(index + 1),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  /*List<Color> _getDifficultyColors(int difficulty) {
    switch (difficulty) {
      case 1:
        return [Colors.green, Colors.green];
      case 2:
        return [Colors.green, const Color(0xffC6CE00)];
      case 3:
        return [Colors.green, const Color(0xffC6CE00), Colors.yellow];
      case 4:
        return [Colors.green, const Color(0xffC6CE00), Colors.yellow, Colors.orange];
      case 5:
        return [Colors.green, const Color(0xffC6CE00), Colors.yellow, Colors.orange, Colors.red];
      default:
        return [Colors.grey, Colors.grey];
    }
  }*/

  Color _getDifficultyColors(int difficulty) {
    switch (difficulty) {
      case 1:
        return Colors.green;
      case 2:
        return const Color(0xffC6CE00);
      case 3:
        return Colors.yellow;
      case 4:
        return Colors.orange;
      case 5:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String greetUser() {
    // Get the current time
    DateTime now = DateTime.now();

    // Extract the current hour from the time
    int hour = now.hour;

    // Check the current hour and return the appropriate greeting
    if (hour >= 12 && hour < 18) {
      return "Good Afternoon";
    } else if (hour >= 18 || hour < 3) {
      return "Good Evening";
    } else {
      return "Good Morning";
    }
  }
}
