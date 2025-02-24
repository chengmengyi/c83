import 'package:flutter/material.dart';
import 'package:ft_a/bean/home_bottom_bean.dart';
import 'package:ft_a/page/home/home_controller.dart';
import 'package:ft_a/widget/coins_widget.dart';
import 'package:ft_a/widget/diamond_widget.dart';
import 'package:ft_base/base/base_widget.dart';
import 'package:ft_base/util/util.dart';
import 'package:ft_base/widget/local_image_widget.dart';
import 'package:ft_base/widget/text_widget.dart';

class HomePage extends BaseWidget<HomeController>{
  @override
  HomeController createController() => HomeController();

  @override
  Widget createWidget() => Scaffold(
    body: GetBuilder<HomeController>(
      id: "page",
      builder: (_)=>Stack(
        alignment: Alignment.bottomCenter,
        children: [
          IndexedStack(
            index: ftController.chooseIndex,
            children: ftController.pageList,
          ),
          _bottomWidget(),
        ],
      ),
    ),
  );

  _bottomWidget()=>SizedBox(
    width: double.infinity,
    height: 88.w,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        LocalImageWidget(image: "home_bottom_bg", width: double.infinity, height: double.infinity),
        Row(
          children: [
            Expanded(child: _bottomItemWidget(ftController.list.first,0)),
            Expanded(child: _bottomItemWidget(ftController.list.last,1)),
          ],
        )
      ],
    ),
  );

  _bottomItemWidget(HomeBottomBean bean,index)=>Container(
    width: double.infinity,
    height: 88.h,
    alignment: Alignment.bottomCenter,
    child: InkWell(
      onTap: (){
        ftController.clickBottom(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LocalImageWidget(image: ftController.chooseIndex==index?bean.sel:bean.uns, width: 36.w, height: 36.w),
          TextWidget(data: bean.text, color: ftController.chooseIndex==index?"#FFDC16":"#8FAAFF", size: 14.sp,fontWeight: FontWeight.bold,),
          SizedBox(height: 6.h,)
        ],
      ),
    ),
  );
}