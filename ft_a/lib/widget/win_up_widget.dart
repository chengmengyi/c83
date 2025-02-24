import 'package:flutter/material.dart';
import 'package:ft_a/hep/game_config_hep.dart';
import 'package:ft_base/util/util.dart';
import 'package:ft_base/widget/text_widget.dart';

class WinUpWidget extends StatelessWidget{
  WinnerType winnerType;
  double? leftFontSize;
  double? rightFontSize;
  String? numTextColor;
  WinUpWidget({
    required this.winnerType,
    this.leftFontSize,
    this.rightFontSize,
    this.numTextColor,
});

  @override
  Widget build(BuildContext context) =>Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      TextWidget(data: "WIN UP TO", color: "#FFFFFF", size: leftFontSize??24.sp,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,),
      SizedBox(width: 2.w,),
      TextWidget(data: "${GameConfigHep.instance.getMaxWinUpNum(winnerType)}", color: numTextColor??"#FF3333", size: rightFontSize??32.sp,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,),
    ],
  );
}