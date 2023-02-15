import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grate_mate/colors/TigersEye.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  void setupGrateMate() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void initState() {
    super.initState();
    setupGrateMate();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: GrateMate.tigersEye,
      body: Center(
        child: Icon(
          Icons.restaurant_menu,
          size: 120,
          color: Colors.white,
        ),
      ),
    );
  }
}
