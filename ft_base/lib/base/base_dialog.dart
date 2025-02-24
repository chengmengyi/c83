import 'package:flutter/material.dart';
import 'package:ft_base/base/base_controller.dart';
import 'package:get/get.dart';

abstract class BaseDialog<T extends BaseController> extends StatelessWidget{
  late T ftController;
  bool _firstInit=true;

  BaseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    ftController=Get.put(createController());
    if(_firstInit){
      initView();
    }
    _firstInit=false;
    return Material(
      type: MaterialType.transparency,
      child: WillPopScope(
        child: Center(
          child: createWidget(),
        ),
        onWillPop: ()async{
          return false;
        },
      ),
    );
  }

  initView(){}

  Widget createWidget();

  T createController();
}