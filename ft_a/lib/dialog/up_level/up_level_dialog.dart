import 'package:flutter/material.dart';
import 'package:ft_a/dialog/up_level/up_level_controller.dart';
import 'package:ft_a/hep/user_info_hep.dart';
import 'package:ft_base/base/base_dialog.dart';
import 'package:ft_base/routers/routers_utils.dart';
import 'package:ft_base/util/util.dart';
import 'package:ft_base/widget/local_image_widget.dart';
import 'package:ft_base/widget/text_widget.dart';

class UpLevelDialog extends BaseDialog<UpLevelController>{
  Function() dismiss;
  UpLevelDialog({required this.dismiss});
  @override
  UpLevelController createController() => UpLevelController();

  @override
  Widget createWidget() => Container(
    width: double.infinity,
    height: 360.h,
    margin: EdgeInsets.only(left: 40.w,right: 40.w),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        LocalImageWidget(image: "up1", width: double.infinity, height: double.infinity),
        Positioned(
          top: 4.h,
          left: 16.w,
          child: TextWidget(data: "Level Up", color: "#FFFFFF", size: 24.sp,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,),
        ),
        Positioned(
          top: 0,
          right: 8.w,
          child: InkWell(
            onTap: (){
              RouterUtils.back();
            },
            child: LocalImageWidget(image: "icon_close", width: 28.w, height: 28.h),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                LocalImageWidget(image: "up2", width: 32.w, height: 32.h),
                SizedBox(width: 8.w,),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    LocalImageWidget(image: "up3", width: 120.w, height: 20.h),
                    LocalImageWidget(image: "up4", width: 116.w, height: 16.h),
                    TextWidget(data: "3/3", color: "#FFFFFF", size: 14.sp,fontWeight: FontWeight.bold,),
                  ],
                ),
                SizedBox(width: 8.w,),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    LocalImageWidget(image: "icon_level", width: 32.w, height: 32.w),
                    TextWidget(data: "${UserInfoHep.instance.getUserDiamond()~/3}", color: "#FFE227", size: 14.sp,fontWeight: FontWeight.bold,)
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h,),
            TextWidget(data: "Collect enough diamonds to level up", color: "#5A5A5A", size: 12.sp),
            LocalImageWidget(image: "up5", width: 100.w, height: 100.h),
            TextWidget(data: "+800", color: "#FFD725", size: 21.sp,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,),
            SizedBox(height: 24.h,),
            InkWell(
              onTap: (){
                ftController.clickGet(dismiss);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  LocalImageWidget(image: "add4", width: 218.w, height: 38.h),
                  TextWidget(data: "Claim", color: "#FFFFFF", size: 18.sp,fontWeight: FontWeight.bold,)
                ],
              ),
            ),
            SizedBox(height: 20.h,),
          ],
        )
      ],
    ),
  );
}