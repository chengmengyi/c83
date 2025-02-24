import 'package:flutter/material.dart';
import 'package:ft_a/bean/winner_back_bean.dart';
import 'package:ft_a/page/casino_rush4/casino_rush_controller.dart';
import 'package:ft_a/widget/play_num_widget.dart';
import 'package:ft_a/widget/play_top_widget.dart';
import 'package:ft_a/widget/win_up_widget.dart';
import 'package:ft_base/base/base_widget.dart';
import 'package:ft_base/util/util.dart';
import 'package:ft_base/widget/local_image_widget.dart';
import 'package:ft_base/widget/text_widget.dart';

class CasinoRushPage extends BaseWidget<CasinoRushController>{
  @override
  CasinoRushController createController() => CasinoRushController();

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
        LocalImageWidget(image: "rush1", width: 312.w, height: 440.h),
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
            image: Image.asset('ft_resource/image/rush2.webp',fit: BoxFit.fill,),
            child: GetBuilder<CasinoRushController>(
              id: "play",
              builder: (_)=>SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    LocalImageWidget(image: "rush6", width: double.infinity, height: double.infinity),
                    LayoutBuilder(
                      builder: (context,bc){
                        var maxHeight = bc.maxHeight;
                        return Container(
                          width: double.infinity,
                          height: double.infinity,
                          margin: EdgeInsets.all(4.w),
                          child: StaggeredGridView.countBuilder(
                            padding: const EdgeInsets.all(0),
                            itemCount: ftController.winnerRewardList.length,
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                              var bean = ftController.winnerRewardList[index];
                              var indexWhere = ftController.winnerRewardList.indexWhere((element) => element.winType==WinType.diamond);
                              return Container(
                                height: maxHeight/2,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 96.w,
                                      height: 96.h,
                                      child: Stack(
                                        children: [
                                          StaggeredGridView.countBuilder(
                                            padding: const EdgeInsets.all(0),
                                            itemCount: bean.iconList.length,
                                            shrinkWrap: true,
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 0,
                                            crossAxisSpacing: 0,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context,index){
                                              return Container(
                                                width: 32.w,
                                                height: 32.h,
                                                alignment: Alignment.center,
                                                child: ,
                                              );
                                            },
                                            staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
                          ),
                        );
                      },
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

  _numWidget()=>GetBuilder<CasinoRushController>(
    id: "num",
    builder: (_)=>PlayNumWidget(winnerType: ftController.winnerType),
  );

  _diamondWidget()=>GetBuilder<CasinoRushController>(
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