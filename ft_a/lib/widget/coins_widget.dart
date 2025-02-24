import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ft_a/hep/user_info_hep.dart';
import 'package:ft_base/util/event/event_code.dart';
import 'package:ft_base/util/event/event_data.dart';
import 'package:ft_base/util/util.dart';
import 'package:ft_base/widget/local_image_widget.dart';
import 'package:ft_base/widget/text_widget.dart';

class CoinsWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CoinsWidgetState();
}

class _CoinsWidgetState extends State<CoinsWidget>{
  StreamSubscription<EventData>? _ss;

  @override
  void initState() {
    super.initState();
    _ss=eventBus.on<EventData>().listen((event) {
      if(event.code==EventCode.updateUserCoinsA){
        setState(() {});
      }
    });
  }
  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.centerLeft,
    children: [
      Container(
        height: 28.h,
        margin: EdgeInsets.only(left: 16.w),
        padding: EdgeInsets.only(left: 20.w,right: 20.w),
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("ft_resource/image/coins_bg.webp"),fit: BoxFit.fill),
        ),
        child: TextWidget(data: "${UserInfoHep.instance.getUserCoins()}", color: "#FFFFFF", size: 18.sp,fontWeight: FontWeight.bold,),
      ),
      LocalImageWidget(image: "icon_coins", width: 32.w, height: 32.w)
    ],
  );

  @override
  void dispose() {
    super.dispose();
    _ss?.cancel();
  }
}