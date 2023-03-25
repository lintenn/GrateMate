import 'package:flutter/material.dart';

class MateTextP extends StatelessWidget {
  final String text;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const MateTextP({
    super.key,
    required this.text,
    this.fontFamily = 'Montserrat',
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
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
      ),
    );
  }
}
class MateTextPStyle {

  static const normalBlack14 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static const boldBlack14 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const normalWhite14 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static const boldWhite14 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}

