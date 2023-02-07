import 'package:flutter/material.dart';
import 'package:grate_mate/recipe.dart';

class MainPage extends StatefulWidget{
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{

  Recipe recipe = Recipe("Crepes", "Original french dessert",
      ["Prepare ingredients","Finish recipe"],
      3, 30,
      "https://vod-hogarmania.atresmedia.com/hogarmania/images/images01/2019/05/20/5ce265e7fa7dec0001ed6f24/1239x697.jpg");

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
              child: ListView(
                children: <Widget>[
                  Card(
                    child: ListTile(
                      leading:
                      Image.network(recipe.imageURL),
                      title: Text(recipe.name),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading:
                      Image.network('https://i.imgur.com/A14QwVWb.jpg'),
                      title: Text('Dummy Image 2'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading:
                      Image.network('https://i.imgur.com/CUG0Aofb.jpg'),
                      title: Text('Dummy Image 3'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading:
                      Image.network('https://i.imgur.com/eTuCPxMb.jpg'),
                      title: Text('Dummy Image 4'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}