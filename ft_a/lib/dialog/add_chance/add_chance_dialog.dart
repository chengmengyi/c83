import 'package:flutter/material.dart';
import 'package:ft_a/dialog/add_chance/add_chance_controller.dart';
import 'package:ft_a/hep/game_config_hep.dart';
import 'package:ft_base/base/base_dialog.dart';
import 'package:ft_base/routers/routers_utils.dart';
import 'package:ft_base/util/util.dart';
import 'package:ft_base/widget/local_image_widget.dart';
import 'package:ft_base/widget/text_widget.dart';

class AddChanceDialog extends BaseDialog<AddChanceController>{
  WinnerType winnerType;
  AddChanceDialog({required this.winnerType});

  @override
  AddChanceController createController() => AddChanceController();

  @override
  Widget createWidget() => Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 40.w,right: 40.w),
    child: SizedBox(
      width: double.infinity,
      height: 260.h,
      child: Stack(
        children: [
          LocalImageWidget(image: "add1", width: double.infinity, height: 260.h),
          Positioned(
            top: 5.h,
            left: 12.w,
            child: TextWidget(data: "More Cards", color: "#FFFFFF", size: 24.sp,fontWeight: FontWeight.bold,),
          ),
          Positioned(
            right: 10.w,
            child: InkWell(
              onTap: (){
                RouterUtils.back();
              },
              child: LocalImageWidget(image: "icon_close", width: 28.w, height: 28.w),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 56.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LocalImageWidget(image: "add2", width: 84.w, height: 84.w),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      LocalImageWidget(image: "add3", width: 64.w, height: 64.w),
                      TextWidget(data: "x1", color: "#FFFFFF", size: 24.sp,fontWeight: FontWeight.bold,)
                    ],
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(18.w),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        ftController.clickVideo(winnerType);
                      },
                      child: SizedBox(
                        width: double.infinity,
                        height: 40.h,
                        child: Stack(
                          children: [
                            LocalImageWidget(image: "add4", width: double.infinity, height: 40.h),
                            Align(
                              child: TextWidget(data: "GET", color: "#FFFFFF", size: 18.sp,fontWeight: FontWeight.bold,),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.only(left: 10.w),
                                child: LocalImageWidget(image: "icon_video", width: 18.w, height: 18.w),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w,),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        ftController.clickCoins(winnerType);
                      },
                      child: SizedBox(
                        width: double.infinity,
                        height: 40.h,
                        child: Stack(
                          children: [
                            LocalImageWidget(image: "add5", width: double.infinity, height: 40.h),
                            Align(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextWidget(data: "Spend", color: "#FFFFFF", size: 14.sp,fontWeight: FontWeight.bold,),
                                  SizedBox(width: 2.w,),
                                  LocalImageWidget(image: "icon_coins", width: 16.w, height: 16.w),
                                  SizedBox(width: 2.w,),
                                  TextWidget(data: "1000", color: "#FFD725", size: 14.sp,fontWeight: FontWeight.bold,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}