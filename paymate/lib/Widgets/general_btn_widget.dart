import 'package:flutter/material.dart';

import '../apptheme/colors/colors_app.dart';

class GBtnWidget extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color color;
  final Color txtColor;
  final double bRadius;
  final double fontSize;
  final FontWeight fontWight;
  const GBtnWidget({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.color,
    required this.bRadius,
    required this.txtColor,
    required this.fontSize,
    required this.fontWight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(bRadius),
        color: color,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: txtColor,
          fontWeight: fontWight,
        ),
      ),
    );
  }
}
