import 'package:flutter/material.dart';
import 'package:ft_a/widget/coins_widget.dart';
import 'package:ft_a/widget/diamond_widget.dart';
import 'package:ft_base/util/util.dart';
import 'package:ft_base/widget/local_image_widget.dart';

class PlayTopWidget extends StatelessWidget{
  Function() clickBack;
  GlobalKey? globalKey;
  PlayTopWidget({required this.clickBack,this.globalKey});

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(width: 12.w,),
      InkWell(
        onTap: (){
          clickBack.call();
        },
        child: LocalImageWidget(image: "icon_back", width: 32.w, height: 32.w),
      ),
      SizedBox(width: 12.w,),
      CoinsWidget(),
      SizedBox(width: 12.w,),
      DiamondWidget(globalKey: globalKey,),
    ],
  );
}