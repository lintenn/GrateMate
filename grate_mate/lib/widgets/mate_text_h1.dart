import 'package:flutter/material.dart';

class MateTextH1 extends StatelessWidget {
  final String text;
  final String fontFamily;
  final double fontSize;
  final Color color;
  final double wordSpacing;

  const MateTextH1({
    super.key,
    required this.text,
    this.fontFamily = 'MontserratExtraBold',
    this.fontSize = 25,
    this.color = Colors.black,
    this.wordSpacing = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: color,
          wordSpacing: wordSpacing
      ),
    );
  }
}

