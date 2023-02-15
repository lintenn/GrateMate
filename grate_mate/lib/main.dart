import 'package:flutter/material.dart';
import 'package:grate_mate/screens/bookmarks_screen.dart';
import 'package:grate_mate/screens/profile_screen.dart';
import 'package:grate_mate/screens/recipe_screen.dart';
import 'package:grate_mate/screens/shoppingList_screen.dart';
import 'screens/mainPage.dart';
import 'screens/recipe_screen.dart';
import 'colors/TigersEye.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GrateMate - Recipes for everyone',
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
        primarySwatch: GrateMate.tigersEye,
        fontFamily: 'Roboto',


      ),
      //home: const RecipeScreen(),
      initialRoute: '/home',
      routes: {
        '/recipe': (context) => const RecipeScreen(),
        '/home': (context) => const MyHomePage(title: 'GrateMate - Main Page')
      }
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
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Explore',
      style: optionStyle,
    ),
    Text(
      'Index 2: Notifications',
      style: optionStyle,
    ),
    Text(
      'Index 3: Profile',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: GrateMate.tigersEye
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Bookmarks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Shopping List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: GrateMate.cornsilk,
          unselectedItemColor: GrateMate.earthYellow,
          onTap: _onItemTapped,
        ),
      ),
      //body: _pageOptions[_selectedIndex],
      body: _buildPageContent(),
    );
  }
  Widget _buildPageContent() {
    switch (_selectedIndex) {
      case 0:
        return MainPage();
      case 1:
        return Bookmark();
      case 2:
        return ShoppingList();
      case 3:
        return Profile();
      default:
        return const Scaffold(
            body: Text('Other page'),
        );
    }
  }

}
