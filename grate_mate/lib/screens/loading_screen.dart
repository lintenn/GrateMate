import 'package:flutter/material.dart';
import 'package:grate_mate/global_information//colors_palette.dart';

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
    return Scaffold(
      backgroundColor: GrateMate.deepBlueGrateMate,
      body: Center(
        child: Image.asset('assets/logo_new.png', height: 120),
      ),
    );
  }
}
