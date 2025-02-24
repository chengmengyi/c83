import 'package:flutter/material.dart';
import 'package:ft_base/base/base_controller.dart';
import 'package:get/get.dart';

abstract class BaseWidget<T extends BaseController> extends StatelessWidget{
  late T ftController;
  bool _firstInit=true;

  BaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ftController=Get.put(createController());
    if(_firstInit){
      initView();
    }
    _firstInit=false;
    return createWidget();
  }

  initView(){}

  Widget createWidget();

  T createController();
}