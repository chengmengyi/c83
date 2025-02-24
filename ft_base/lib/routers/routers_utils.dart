import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouterUtils{
  static toNamed({required String routersName,Map<String, dynamic>? params})async{
    Get.toNamed(routersName,arguments: params);
  }

  static offNamed({required String routersName}){
    Get.offNamed(routersName);
  }

  static back(){
    Get.back();
  }

  static dialog({required Widget widget,dynamic arguments, bool? barrierDismissible, Color? barrierColor}){
    Get.dialog(
      widget,
      arguments: arguments,
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible ?? false,
    );
  }
}