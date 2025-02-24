import 'package:flutter/material.dart';
import 'package:ft_a/dialog/no_win/no_win_controller.dart';
import 'package:ft_base/base/base_dialog.dart';
import 'package:ft_base/routers/routers_utils.dart';
import 'package:ft_base/util/util.dart';
import 'package:ft_base/widget/local_image_widget.dart';
import 'package:ft_base/widget/text_widget.dart';

class NoWinDialog extends BaseDialog<NoWinController>{
  Function() dismiss;
  NoWinDialog({required this.dismiss});
  @override
  NoWinController createController() => NoWinController();

  @override
  Widget createWidget() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      LocalImageWidget(image: "big6", width: 204.w, height: 140.h),
      SizedBox(height: 60.h,),
      InkWell(
        onTap: (){
          RouterUtils.back();
          dismiss.call();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            LocalImageWidget(image: "big7", width: 200.w, height: 58.h),
            TextWidget(data: "Play Again", color: "#FFFFFF", size: 24.sp,fontWeight: FontWeight.bold,),
          ],
        ),
      )
    ],
  );
}