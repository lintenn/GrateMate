import 'package:flutter/material.dart';

class MateTextH2 extends StatelessWidget {
  final String text;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final double wordSpacing;

  const MateTextH2({
    super.key,
    required this.text,
    this.fontFamily = 'MontserratExtraBold',
    this.fontSize = 20,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.wordSpacing = 0,
  });

  const MateTextH2.appBar({
    super.key,
    required this.text,
    this.fontFamily = 'MontserratExtraBold',
    this.fontSize = 20,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.white,
    this.wordSpacing = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        wordSpacing: wordSpacing
      ),
    );
  }
}
