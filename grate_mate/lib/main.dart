import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[    Text(      'Index 0: Home',      style: optionStyle,    ),    Text(      'Index 1: Explore',      style: optionStyle,    ),    Text(      'Index 2: Notifications',      style: optionStyle,    ),    Text(      'Index 3: Profile',      style: optionStyle,    ),  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      Future.delayed(Duration(seconds: 5), () {
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label:'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Container(
    //       height: 50,
    //       child: TextField(
    //         controller: _searchController,
    //         decoration: InputDecoration(
    //           hintText: 'Search',
    //           suffixIcon: IconButton(
    //             icon: Icon(Icons.search),
    //             onPressed: _search,
    //           ),
    //           border: OutlineInputBorder(
    //             borderRadius: BorderRadius.all(
    //               Radius.circular(25),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    //   body: _showError
    //       ? Center(
    //     child: Text('Debes escribir algo'),
    //   )
    //       : Container(),
    // );

  }
}

