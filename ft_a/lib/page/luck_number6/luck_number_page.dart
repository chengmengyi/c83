import 'package:ft_a/page/luck_number6/luck_number_controller.dart';
import 'package:ft_base/base/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:ft_a/bean/winner_back_bean.dart';
import 'package:ft_a/widget/play_num_widget.dart';
import 'package:ft_a/widget/play_top_widget.dart';
import 'package:ft_a/widget/win_up_widget.dart';
import 'package:ft_base/util/util.dart';
import 'package:ft_base/widget/local_image_widget.dart';
import 'package:ft_base/widget/text_widget.dart';


class LuckNumberPage extends BaseWidget<LuckNumberController>{
  @override
  LuckNumberController createController() => LuckNumberController();

  @override
  Widget createWidget() => WillPopScope(
    child: Scaffold(
      body: Stack(
        children: [
          LocalImageWidget(image: "play_bg", width: double.infinity, height: double.infinity),
          SafeArea(
            child: Column(
              children: [
                PlayTopWidget(
                  globalKey: ftController.diamondEndGlobalKey,
                  clickBack: (){
                    ftController.clickBack();
                  },
                ),
                SizedBox(height: 20.h,),
                _playWidget(),
                SizedBox(height: 20.h,),
                _numWidget(),
                SizedBox(height: 10.h,),
                GetBuilder<LuckNumberController>(
                  id: "check_btn",
                  builder: (_)=>InkWell(
                    onTap: (){
                      ftController.clickCheckCard();
                    },
                    child: LocalImageWidget(image: ftController.canPlay?"check_card":"next_card", width: 268.w, height: 84.h),
                  ),
                )
              ],
            ),
          ),
          _diamondWidget(),
          _goldWidget(),
        ],
      ),
    ),
    onWillPop: ()async{
      ftController.clickBack();
      return false;
    },
  );

  _playWidget()=>SizedBox(
    width: 312.w,
    height: 440.h,
    child: Stack(
      children: [
        LocalImageWidget(image: "number1", width: 312.w, height: 440.h),
        Container(
          width: double.infinity,
          height: 248.h,
          margin: EdgeInsets.only(left: 12.w,right: 12.w,top: 102.h),
          child: Scratcher(
            enabled: true,
            brushSize: 40,
            threshold: 70,
            key: ftController.key,
            color: Colors.transparent,
            onThreshold: (){
              ftController.onThreshold();
            },
            onScratchUpdate: (details){
              ftController.updateIconOffset(details);
            },
            onScratchStart: (){
              ftController.onScratchStart();
            },
            onScratchEnd: (){
              ftController.onScratchEnd();
            },
            image: Image.asset('ft_resource/image/number2.webp',fit: BoxFit.fill,),
            child: GetBuilder<LuckNumberController>(
              id: "play",
              builder: (_)=>SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    LocalImageWidget(image: "number3", width: double.infinity, height: double.infinity),
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      margin: EdgeInsets.all(4.w),
                      child: LayoutBuilder(
                        builder: (context,bc){
                          var maxHeight = bc.maxHeight;
                          return StaggeredGridView.countBuilder(
                            padding: const EdgeInsets.all(0),
                            itemCount: ftController.winnerRewardList.length,
                            shrinkWrap: true,
                            crossAxisCount: 5,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                              var bean = ftController.winnerRewardList[index];
                              var indexWhere = ftController.winnerRewardList.indexWhere((element) => element.winType==WinType.diamond);
                              return Container(
                                height: maxHeight/3,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextWidget(data: bean.iconList.first, color: bean.winner?"#FFFB24":"#D7DCE1", size: 30.sp,fontWeight: FontWeight.bold,fontFamily: "ft",fontStyle: FontStyle.italic,),
                                    bean.winType==WinType.coins?
                                    TextWidget(data: "${bean.rewardNum}", color: "#FFD725", size: 14.sp,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,):
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          key: index==indexWhere?ftController.diamondGlobalKey:null,
                                          child: LocalImageWidget(image: "icon_diamond", width: 24.w, height: 24.h),
                                        ),
                                        TextWidget(data: "+1", color: "#FFD725", size: 14.sp,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                            staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 46.h),
            child: WinUpWidget(winnerType: ftController.winnerType,numTextColor: "#FFF70F",),
          ),
        )
      ],
    ),
  );

  _numWidget()=>GetBuilder<LuckNumberController>(
    id: "num",
    builder: (_)=>PlayNumWidget(winnerType: ftController.winnerType),
  );

  _diamondWidget()=>GetBuilder<LuckNumberController>(
    id: "diamond",
    builder: (_){
      var value = ftController.diamondAnimation?.value;
      var dx = value?.dx??0;
      var dy = value?.dy??0;
      return Visibility(
        visible: ftController.showDiamondAnimator,
        child: Container(
          margin: EdgeInsets.only(left: dx<=0?0:dx,top: dy<=0?0:dy),
          child: LocalImageWidget(image: "icon_diamond", width: 24.w, height: 24.h),
        ),
      );
    },
  );


  _goldWidget()=>GetBuilder<LuckNumberController>(
    id: "gold_icon",
    builder: (_){
      var left=null==ftController.iconOffset?0.0:ftController.iconOffset?.dx??0.0;
      var top=null==ftController.iconOffset?0.0:ftController.iconOffset?.dy??0.0;
      return null==ftController.iconOffset?
      Container():
      Container(
        margin: EdgeInsets.only(left: left<0?0:left,top: top<0?0:top),
        child: Image.asset("ft_resource/image/coins.png",width: 40,height: 40),
      );
    },
  );
  
}