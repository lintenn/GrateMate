import 'package:flutter/material.dart';
import 'package:grate_mate/screens/bookmarks_screen.dart';
import 'package:grate_mate/screens/loading_screen.dart';
import 'package:grate_mate/screens/login_screen.dart';
import 'package:grate_mate/screens/profile_screen.dart';
import 'package:grate_mate/screens/recipe_screen.dart';
import 'package:grate_mate/screens/shoppingList_screen.dart';
import 'screens/mainPage.dart';
import 'global_information/colors_palette.dart';
import 'global_information/global_users.dart' as Users;


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
        primarySwatch: GrateMate.deepBlueGrateMate,
        fontFamily: 'Montserrat',



      ),
      //home: const RecipeScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadingScreen(),
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
          canvasColor: GrateMate.deepBlueGrateMate
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
          selectedItemColor: Colors.white,
          unselectedItemColor: GrateMate.grayGrateMate,
          showSelectedLabels: false,
          selectedIconTheme: IconThemeData(size: 30),
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
        return Users.isLogged? ProfileScreen(user: Users.users[1]) : LoginPage();
      default:
        return const Scaffold(
            body: Text('Other page'),
        );
    }
  }

}
