import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ft_base/base/base_controller.dart';
import 'package:ft_base/routers/a_routers_name.dart';
import 'package:ft_base/routers/routers_utils.dart';
import 'package:get/get.dart';

class LaunchController extends BaseController with GetSingleTickerProviderStateMixin{
  late AnimationController _animationController;

  @override
  void onInit() {
    super.onInit();
    _initAnimator();
  }

  @override
  void onReady() {
    super.onReady();
    _animationController.forward();
  }

  _initAnimator(){
    _animationController=AnimationController(duration: const Duration(seconds: 3),vsync: this)
      ..addListener(() {
        update(["progress"]);
      })
      ..addStatusListener((status) {
        if(status==AnimationStatus.completed){
          RouterUtils.toNamed(routersName: ARoutersName.home);
        }
      });
  }

  String getProgressStr()=>"${(_animationController.value*100).toInt()}%";

  double getProgress()=>_animationController.value;

  double getIconMarginLeft(){
    var left = _animationController.value*(200.w);
    var max=168.w;
    if(left>=max){
      return max;
    }
    return left;
  }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }
}