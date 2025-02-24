import 'package:flutter/material.dart';
import 'package:ft_base/util/util.dart';

class TextWidget extends StatelessWidget{
  String data;
  String color;
  double size;
  FontWeight? fontWeight;
  String? fontFamily;
  FontStyle? fontStyle;

  TextWidget({
    required this.data,
    required this.color,
    required this.size,
    this.fontWeight,
    this.fontFamily,
    this.fontStyle,
});

  @override
  Widget build(BuildContext context) => Text(
    data,
    style: TextStyle(
      color: color.toColor(),
      fontSize: size,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      fontStyle: fontStyle,
    ),
  );
}