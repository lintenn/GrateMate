import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        margin: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 0.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
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
                    contentPadding: const EdgeInsets.fromLTRB(25, 20, 0, 20),
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
                fontWeight: FontWeight.bold,
              ),
            )
                : Container(),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(globalRecipes.recipes.length, (index) {
                  return Center(
                    child: Card(
                      margin: const EdgeInsets.all(10.0),
                      child: Column(
                          children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecipeScreen(),
                                ),
                              );
                            },
                            Container(
                              width: 150,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(globalRecipes.recipes[index].imageURL),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              globalRecipes.recipes[index].name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(globalRecipes.recipes[index].description),
                          ),
                        ],
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