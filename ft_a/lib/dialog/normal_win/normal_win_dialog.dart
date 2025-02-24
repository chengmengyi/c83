import 'package:flutter/material.dart';
import 'package:ft_a/dialog/normal_win/normal_win_controller.dart';
import 'package:ft_base/base/base_dialog.dart';
import 'package:ft_base/util/util.dart';
import 'package:ft_base/widget/local_image_widget.dart';
import 'package:ft_base/widget/text_widget.dart';

class NormalWinDialog extends BaseDialog<NormalWinController>{
  int reward;
  Function() dismiss;
  NormalWinDialog({
    required this.reward,
    required this.dismiss,
  });


  @override
  NormalWinController createController() => NormalWinController();

  @override
  Widget createWidget() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _rewardWidget(),
      SizedBox(height: 12.h,),
      _btnWidget(),
    ],
  );

  _rewardWidget()=>SizedBox(
    width: 200.w,
    height: 266.h,
    child: Stack(
      children: [
        LocalImageWidget(image: "big5", width: 200.w, height: 266.h),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 44.h),
            child: Stack(
              alignment: Alignment.center,
              children: [
                LocalImageWidget(image: "big3", width: 180.w, height: 44.h),
                TextWidget(data: "$reward", color: "#FFE32A", size: 24.sp,fontWeight: FontWeight.bold,)
              ],
            ),
          ),
        )
      ],
    ),
  );

  _btnWidget()=>InkWell(
    onTap: (){
      ftController.clickGet(reward,dismiss);
    },
    child: Stack(
      alignment: Alignment.center,
      children: [
        LocalImageWidget(image: "big4", width: 200.w, height: 58.h),
        TextWidget(data: "Claim", color: "#FFFFFF", size: 24.sp,fontWeight: FontWeight.bold,),
      ],
    ),
  );
}