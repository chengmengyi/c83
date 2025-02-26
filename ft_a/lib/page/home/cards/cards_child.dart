import 'package:flutter/material.dart';
import 'package:ft_a/hep/user_info_hep.dart';
import 'package:ft_a/page/home/cards/cards_controller.dart';
import 'package:ft_a/widget/coins_widget.dart';
import 'package:ft_a/widget/diamond_widget.dart';
import 'package:ft_a/widget/win_up_widget.dart';
import 'package:ft_base/base/base_widget.dart';
import 'package:ft_base/util/util.dart';
import 'package:ft_base/widget/local_image_widget.dart';
import 'package:ft_base/widget/text_widget.dart';

class CardsChild extends BaseWidget<CardsController>{
  @override
  CardsController createController() => CardsController();

  @override
  Widget createWidget() => Stack(
    children: [
      LocalImageWidget(image: "home1", width: double.infinity, height: double.infinity),
      SafeArea(
        child: Column(
          children: [
            _topWidget(),
            _selListWidget(),
            SizedBox(height: 16.h,),
            _centerWidget(),
            SizedBox(height: 16.h,),
            _numWidget(),
            SizedBox(height: 16.h,),
            InkWell(
              onTap: (){
                ftController.toPlay();
              },
              child: LocalImageWidget(image: "play", width: 248.w, height: 84.h),
            )
          ],
        ),
      ),
    ],
  );

  _numWidget()=>GetBuilder<CardsController>(
    id: "num",
    builder: (_)=>SizedBox(
      width: 164.w,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            width: 132.w,
            height: 28.w,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 16.w,right: 16.w),
            decoration: BoxDecoration(
                color: "#FFFFFF".toColor(),
                border: Border.all(
                  width: 1.w,
                  color: "#000000".toColor(),
                )
            ),
            child: TextWidget(data: "${UserInfoHep.instance.getPlayNum(ftController.getWinnerTypeByIndex())}", color: "#FFD84B", size: 20.sp,fontWeight: FontWeight.bold,),
          ),
          LocalImageWidget(image: ftController.homeList[ftController.chooseIndex].numIcon, width: 32.w, height: 32.w),
          Align(
            alignment: Alignment.centerRight,
            child: LocalImageWidget(image: "icon_add", width: 32.w, height: 32.w),
          ),
        ],
      ),
    ),
  );

  _centerWidget()=>Row(
    children: [
      SizedBox(width: 12.w,),
      InkWell(
        onTap: (){
          ftController.clickLeft();
        },
        child: LocalImageWidget(image: "icon_left", width: 28.w, height: 28.w),
      ),
      const Spacer(),
      GetBuilder<CardsController>(
        id: "center",
        builder: (_)=>Stack(
          alignment: Alignment.bottomCenter,
          children: [
            LocalImageWidget(image: ftController.homeList[ftController.chooseIndex].center, width: 234.w, height: 330.h),
            Container(
              margin: EdgeInsets.only(bottom: 33.h),
              child: WinUpWidget(
                leftFontSize: 18.sp,
                rightFontSize: 24.sp,
                numTextColor: ftController.getWinUpColor(),
                winnerType: ftController.homeList[ftController.chooseIndex].winnerType,
              ),
            )
          ],
        ),
      ),
      const Spacer(),
      InkWell(
        onTap: (){
          ftController.clickRight();
        },
        child: LocalImageWidget(image: "icon_right", width: 28.w, height: 28.w),
      ),
      SizedBox(width: 12.w,),
    ],
  );

  _selListWidget()=>SizedBox(
    width: double.infinity,
    height: 88.h,
    child: GetBuilder<CardsController>(
      id: "sel_list",
      builder: (_)=>ListView.builder(
        itemCount: ftController.homeList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          var bean = ftController.homeList[index];
          return InkWell(
            onTap: (){
              ftController.clickItem(index);
            },
            child: Container(
              margin: EdgeInsets.only(left: 16.w),
              child: LocalImageWidget(image: index==ftController.chooseIndex?bean.sel:bean.uns, width: 72.w, height: 88.h),
            ),
          );
        },
      ),
    ),
  );

  _topWidget()=>Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(width: 16.w,),
      CoinsWidget(),
      SizedBox(width: 8.w,),
      DiamondWidget(),
      const Spacer(),
      InkWell(
        child: LocalImageWidget(image: "icon_set", width: 32.w, height: 32.w),
      ),
      SizedBox(width: 16.w,),
    ],
  );
}