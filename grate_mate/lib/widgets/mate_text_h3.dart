import 'package:flutter/material.dart';
import 'package:grate_mate/global_information/colors_palette.dart';

class MateTextH3 extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final Color color;
  final double wordSpacing;

  const MateTextH3.bold({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.bold,
    this.color = Colors.black,
    this.wordSpacing = 0,
  });

  const MateTextH3.normal({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.wordSpacing = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        fontWeight: fontWeight,
        color: color,
        wordSpacing: wordSpacing
      ),
    );
  }
}

class MateTextH3Style {
  static const normalBlack16 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static const boldBlack16 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const normalWhite16 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  static const boldWhite16 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const boldBlue16 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: GrateMate.deepBlueGrateMate,
  );

}