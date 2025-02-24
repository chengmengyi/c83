import 'package:flutter/material.dart';
import 'package:ft_base/base/base_widget.dart';
import 'package:ft_base/base_page/launch_page/launch_controller.dart';
import 'package:ft_base/util/util.dart';
import 'package:ft_base/widget/local_image_widget.dart';
import 'package:ft_base/widget/text_widget.dart';

class LaunchPage extends BaseWidget<LaunchController>{
  @override
  LaunchController createController() => LaunchController();

  @override
  Widget createWidget() => Scaffold(
    body: Stack(
      alignment: Alignment.topCenter,
      children: [
        LocalImageWidget(image: "launch", width: double.infinity, height: double.infinity),
        Column(
          children: [
            SizedBox(height: 116.h,),
            LocalImageWidget(image: "launch2", width: 245.w, height: 210.h),
            const Spacer(),
            _progressWidget(),
            SizedBox(height: 116.h,),
          ],
        )
      ],
    ),
  );

  _progressWidget()=>GetBuilder<LaunchController>(
    id: "progress",
    builder: (_)=>Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextWidget(data: "Loading... ${ftController.getProgressStr()}", color: "#FFFFFF", size: 14.sp,fontWeight: FontWeight.bold,),
        SizedBox(height: 10.h,),
        SizedBox(
          width: 200.w,
          height: 32.w,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                width: double.infinity,
                height: 12.h,
                color: "#060832".toColor(),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 2.w,right: 2.w),
                child: Container(
                  width: (196.w)*ftController.getProgress(),
                  height: 8.h,
                  color: "#FFD84B".toColor(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: ftController.getIconMarginLeft()),
                child: LocalImageWidget(image: "launch3", width: 32.w, height: 32.w),
              ),
            ],
          ),
        )
      ],
    ),
  );
}