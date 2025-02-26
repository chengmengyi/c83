import 'package:flutter/material.dart';
import 'package:ft_a/bean/winner_back_bean.dart';
import 'package:ft_a/page/win_or_lose5/win_or_lose_controller.dart';
import 'package:ft_a/widget/play_num_widget.dart';
import 'package:ft_a/widget/play_top_widget.dart';
import 'package:ft_a/widget/win_up_widget.dart';
import 'package:ft_base/base/base_widget.dart';
import 'package:ft_base/util/util.dart';
import 'package:ft_base/widget/local_image_widget.dart';
import 'package:ft_base/widget/text_widget.dart';

class WinOrLosePage extends BaseWidget<WinOrLoseController>{
  @override
  WinOrLoseController createController() => WinOrLoseController();

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
        LocalImageWidget(image: "lose1", width: 312.w, height: 440.h),
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
            // onScratchUpdate: (details){
            //   smController.updateIconOffset(details);
            // },
            onScratchStart: (){
              ftController.onScratchStart();
            },
            onScratchEnd: (){
              ftController.onScratchEnd();
            },
            image: Image.asset('ft_resource/image/lose2.webp',fit: BoxFit.fill,),
            child: GetBuilder<WinOrLoseController>(
              id: "play",
              builder: (_)=>SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    LocalImageWidget(image: "lose3", width: double.infinity, height: double.infinity),
                    Container(
                      margin: EdgeInsets.all(4.w),
                      child: LayoutBuilder(
                        builder: (context,bc){
                          var maxWidth = bc.maxWidth;
                          var maxHeight = bc.maxHeight;
                          return Column(
                            children: [
                              Row(
                                children: List.generate(3, (index) => Container(
                                  width: maxWidth/3,
                                  height: 20.h,
                                  alignment: Alignment.center,
                                  child: TextWidget(data: index==0?"Your Card":index==1?"Check Card":"Win", color: "#FFFFFF", size: 12.sp,fontWeight: FontWeight.bold,),
                                )),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: ftController.winnerRewardList.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context,index){
                                    var bean = ftController.winnerRewardList[index];
                                    var indexWhere = ftController.winnerRewardList.indexWhere((element) => element.winType==WinType.diamond);
                                    return Row(
                                      children: List.generate(3, (i) => Container(
                                        width: maxWidth/3,
                                        height: (maxHeight-20.h)/4,
                                        alignment: Alignment.center,
                                        child: i<2?
                                        LocalImageWidget(image: bean.iconList[i], width: 34.w, height: 46.h):
                                        (bean.winType==WinType.coins?
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
                                        )),
                                      )),
                                    );
                                  },
                                ),
                              )
                            ],
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

  _numWidget()=>GetBuilder<WinOrLoseController>(
    id: "num",
    builder: (_)=>PlayNumWidget(winnerType: ftController.winnerType),
  );

  _diamondWidget()=>GetBuilder<WinOrLoseController>(
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