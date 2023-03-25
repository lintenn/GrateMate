import 'package:flutter/material.dart';

class MateTextError extends StatelessWidget {
  final String text;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const MateTextError({
    super.key,
    required this.text,
    this.fontFamily = 'Montserrat',
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.red,
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
