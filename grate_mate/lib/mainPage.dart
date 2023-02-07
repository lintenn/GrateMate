import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});





}

class _mainPageState() extends State<mainPage>{
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
          _showError?
          const Text('You have to enter a search term',
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
                    leading: Image.network('https://i.imgur.com/v6B7cZsb.jpg'),
                    title: Text('Dummy Image 1'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Image.network('https://i.imgur.com/A14QwVWb.jpg'),
                    title: Text('Dummy Image 2'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Image.network('https://i.imgur.com/CUG0Aofb.jpg'),
                    title: Text('Dummy Image 3'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Image.network('https://i.imgur.com/eTuCPxMb.jpg'),
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