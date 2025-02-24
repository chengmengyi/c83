import 'package:flutter/material.dart';

class LocalImageWidget extends StatelessWidget{
  String image;
  double width;
  double height;
  BoxFit? boxFit;

  LocalImageWidget({
    required this.image,
    required this.width,
    required this.height,
    this.boxFit,
});

  @override
  Widget build(BuildContext context) => Image.asset(
    "ft_resource/image/$image.webp",
    width: width,
    height: height,
    fit: boxFit??BoxFit.fill,
  );
}