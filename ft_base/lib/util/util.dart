import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:get_storage/get_storage.dart';
export 'package:get/get.dart';
export 'package:scratcher/scratcher.dart';
export 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


extension String2Color on String{
  Color toColor(){
    var hexStr = replaceAll("#", "");
    return Color(int.parse(hexStr, radix: 16)).withAlpha(255);
  }
}

extension StringBase64 on String{
  String base64()=>const Utf8Decoder().convert(base64Decode(this));
}

extension RandomList on List{
  random()=> this[Random().nextInt(length)];
}

///随机取数据
///count取多少个
///maxRepeat最多重复数
List<String> randomSelect(List<String> list, int count, int maxRepeat) {
  List<String> result = [];
  Random random = Random();

  for (int i = 0; i < count; i++) {
    String randomElement = list[random.nextInt(list.length)];

    int repeatCount = result.where((element) => element == randomElement).length;
    if (repeatCount < maxRepeat) {
      result.add(randomElement);
    } else {
      i--;
    }
  }
  return result;
}

showToast(String text){
  if(text.isEmpty){
    return;
  }
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 16
  );
}
