import 'package:flutter/material.dart';
import 'package:ft_a/bean/winner_back_bean.dart';
import 'package:ft_a/page/fruit_match2/fruit_match_controller.dart';
import 'package:ft_a/widget/play_num_widget.dart';
import 'package:ft_a/widget/play_top_widget.dart';
import 'package:ft_a/widget/win_up_widget.dart';
import 'package:ft_base/base/base_widget.dart';
import 'package:ft_base/util/util.dart';
import 'package:ft_base/widget/local_image_widget.dart';
import 'package:ft_base/widget/text_widget.dart';

class FruitMatchPage extends BaseWidget<FruitMatchController>{
  @override
  FruitMatchController createController() => FruitMatchController();

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
                SizedBox(height: 60.h,),
                _playWidget(),
                SizedBox(height: 20.h,),
                _numWidget(),
                SizedBox(height: 10.h,),
                InkWell(
                  onTap: (){
                    ftController.clickCheckCard();
                  },
                  child: LocalImageWidget(image: "check_card", width: 268.w, height: 84.h),
                )
              ],
            ),
          ),
          _diamondWidget(),
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
        LocalImageWidget(image: "fruit1", width: 312.w, height: 440.h),
        Container(
          width: double.infinity,
          height: 212.h,
          margin: EdgeInsets.only(left: 12.w,right: 12.w,top: 134.h),
          child: Scratcher(
            enabled: true,
            brushSize: 40,
            threshold: 70,
            key: ftController.key,
            color: Colors.transparent,
            onThreshold: (){
              ftController.onThreshold();
            },
            // onScratchUpdate: (details){
            //   smController.updateIconOffset(details);
            // },
            onScratchStart: (){
              ftController.onScratchStart();
            },
            onScratchEnd: (){
              ftController.onScratchEnd();
            },
            image: Image.asset('ft_resource/image/fruit2.webp',fit: BoxFit.fill,),
            child: GetBuilder<FruitMatchController>(
              id: "play",
              builder: (_)=>SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    LocalImageWidget(image: "fruit7", width: double.infinity, height: double.infinity),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(4.w),
                          child: LayoutBuilder(
                            builder: (context,bc){
                              var maxWidth = bc.maxWidth;
                              return SizedBox(
                                width: double.infinity,
                                height: 64.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: ftController.winnerRewardList.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context,index){
                                    var bean = ftController.winnerRewardList[index];
                                    return Container(
                                      width: maxWidth/6,
                                      height: 64.h,
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          LocalImageWidget(image: bean.iconList.first, width: 36.w, height: 36.w),
                                          bean.winType==WinType.coins?
                                          TextWidget(data: "${bean.rewardNum}", color: "#FFD725", size: 14.sp,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,):
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                key: index==0&&bean.winType==WinType.diamond?ftController.diamondGlobalKey:null,
                                                child: LocalImageWidget(image: "icon_diamond", width: 24.w, height: 24.h),
                                              ),
                                              TextWidget(data: "+1", color: "#FFD725", size: 14.sp,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextWidget(data: "Winning Symbol", color: "#D6D7D8", size: 14.sp,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,),
                                SizedBox(height: 20.h,),
                                LocalImageWidget(image: ftController.getRewardIcon(), width: 68.w, height: 68.w)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
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

  _numWidget()=>GetBuilder<FruitMatchController>(
    id: "num",
    builder: (_)=>PlayNumWidget(winnerType: ftController.winnerType),
  );

  _diamondWidget()=>GetBuilder<FruitMatchController>(
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
}