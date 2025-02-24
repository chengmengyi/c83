import 'package:flutter/material.dart';
import 'package:ft_a/dialog/big_win/big_win_controller.dart';
import 'package:ft_base/base/base_dialog.dart';
import 'package:ft_base/util/util.dart';
import 'package:ft_base/widget/local_image_widget.dart';
import 'package:ft_base/widget/text_widget.dart';

class BigWinDialog extends BaseDialog<BigWinController>{
   int reward;
   Function() dismiss;
   BigWinDialog({
     required this.reward,
     required this.dismiss,
});

  @override
  BigWinController createController() => BigWinController();

  @override
  Widget createWidget() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _bigWidget(),
      SizedBox(height: 30.h,),
      _btnWidget(),
    ],
  );

  _bigWidget()=>Stack(
    alignment: Alignment.bottomCenter,
    children: [
      LocalImageWidget(image: "big1", width: 280.w, height: 280.w),
      Container(
        margin: EdgeInsets.only(bottom: 30.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LocalImageWidget(image: "big2", width: 160.w, height: 124.h),
            Stack(
              alignment: Alignment.center,
              children: [
                LocalImageWidget(image: "big3", width: 180.w, height: 44.h),
                TextWidget(data: "$reward", color: "#FFE32A", size: 24.sp,fontWeight: FontWeight.bold,)
              ],
            )
          ],
        ),
      )
    ],
  );

  _btnWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      InkWell(
        onTap: (){
          ftController.clickDou(reward,dismiss);
        },
        child: SizedBox(
          width: 200.w,
          height: 58.h,
          child: Stack(
            children: [
              LocalImageWidget(image: "big4", width: 200.w, height: 58.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 20.w),
                  child: LocalImageWidget(image: "icon_video", width: 20.w, height: 20.w),
                ),
              ),
              Align(
                child: TextWidget(data: "${reward*2}", color: "#FFFFFF", size: 24.sp,fontWeight: FontWeight.bold,),
              )
            ],
          ),
        ),
      ),
      InkWell(
        onTap: (){
          ftController.clickSingle(reward,dismiss);
        },
        child: TextWidget(data: "$reward", color: "#FFFFFF", size: 18.sp,),
      )
    ],
  );
}