import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors/TigersEye.dart';
import '../models/globalRecipes.dart' as globalRecipes;
import 'package:grate_mate/models/recipe.dart';
import 'package:grate_mate/screens/recipe_screen.dart';

class MainPage extends StatefulWidget{
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{

  final _searchController = TextEditingController();
  bool _showError = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
      // Almacena el valor de la búsqueda en una variable
      String searchValue = _searchController.text;
      print(searchValue);
    }
  }

  Widget recipeCard(recipe){
    return Card(

    );
  }

  List<Color> _getDifficultyColors(int difficulty) {
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
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GrateMate.earthYellow[400],
      body: Container(
        margin: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 20.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
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
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
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
                ? const Text(
              'You have to enter a search term',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xFFFD5D5D),
              ),
            )
                : Container(),
            Row(
              children: [
                Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: Text(
                        'Last recipes added',
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'RobotoBold'
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Flexible(
              child: GridView.count(
                crossAxisCount: 1,
                scrollDirection: Axis.vertical,
                children: List.generate(globalRecipes.recipes.length, (index) {
                  return Center(
                    child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                //TODO I think that if here i put the info i can catch it later and change to router
                                builder: (context) => RecipeScreen(),
                              ),
                            );
                          },
                      child: Card(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        shape:  RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                              child: Text(
                                globalRecipes.recipes[index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,),
                              ),
                            ),
                            AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Image.asset(globalRecipes.recipes[index].imageURL,
                                    fit: BoxFit.cover
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                              child: Text(globalRecipes.recipes[index].description),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 4, 20, 8),
                              child:  FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: globalRecipes.recipes[index].difficulty / 5,
                                  child: Container(
                                    height: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      gradient: LinearGradient(
                                        colors: _getDifficultyColors(globalRecipes.recipes[index].difficulty),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                              child: Row(
                                children: [
                                  Icon(Icons.access_time),
                                  SizedBox(width: 5),
                                  Text("${globalRecipes.recipes[index].time} min"),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

}