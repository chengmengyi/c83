import 'package:ft_base/base/base_controller.dart';
import 'package:ft_base/util/util.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ft_a/bean/winner_back_bean.dart';
import 'package:ft_a/bean/winner_reward_bean.dart';
import 'package:ft_a/dialog/add_chance/add_chance_dialog.dart';
import 'package:ft_a/dialog/big_win/big_win_dialog.dart';
import 'package:ft_a/dialog/no_win/no_win_dialog.dart';
import 'package:ft_a/dialog/normal_win/normal_win_dialog.dart';
import 'package:ft_a/hep/game_config_hep.dart';
import 'package:ft_a/hep/played_num_hep.dart';
import 'package:ft_a/hep/user_info_hep.dart';
import 'package:ft_base/routers/routers_utils.dart';
import 'package:ft_base/util/event/event_code.dart';
import 'package:ft_base/util/event/event_result.dart';

class LuckNumberController extends BaseController with GetTickerProviderStateMixin{
  var startScratch=false,showDiamondAnimator=false;
  WinnerType winnerType=WinnerType.luckyNumber;
  late WinnerBackBean _winnerBackBean;
  List<WinnerRewardBean> winnerRewardList=[];
  final key = GlobalKey<ScratcherState>();
  GlobalKey diamondGlobalKey=GlobalKey();
  GlobalKey diamondEndGlobalKey=GlobalKey();

  Offset diamondEndOffset=Offset.zero;
  late AnimationController diamondLottieController;
  Animation<Offset>? diamondAnimation;

  @override
  void onInit() {
    super.onInit();
    diamondLottieController=AnimationController(vsync: this,duration: const Duration(milliseconds: 2000))
      ..addListener(() {
        update(["diamond"]);
      })
      ..addStatusListener((status) {
        if(status==AnimationStatus.completed){
          UserInfoHep.instance.updateUserDiamond(_winnerBackBean.winNum);
          showDiamondAnimator=false;
          update(["diamond"]);
          _reset();
        }
      });
  }

  @override
  void onReady() {
    super.onReady();
    _initWinnerBean();
  }

  _initWinnerBean(){
    _winnerBackBean = GameConfigHep.instance.getWinnerBean(winnerType);
    winnerRewardList.clear();
    List<int> excludedList=[];
    if(_winnerBackBean.winNum>0){
      excludedList.addAll(_getRandomNumbersWithSet(_winnerBackBean.winNum));
      for (var value in excludedList) {
        for (int i = 0; i < 3; i++) {
          winnerRewardList.add(WinnerRewardBean(rewardNum: _winnerBackBean.coinsNum, winType: _winnerBackBean.winType, winner: true, iconList: ["$value"]));
        }
      }
    }
    List<int> otherList=[];
    while(otherList.length<(15-_winnerBackBean.winNum*3)){
      var number = Random().nextInt(GameConfigHep.instance.getMaxLuckNumber());
      if(!excludedList.contains(number)){
        otherList.add(number);
      }
    }
    for(var value in otherList){
      winnerRewardList.add(WinnerRewardBean(rewardNum: Random().nextInt(_winnerBackBean.rewardNormal), winType: WinType.coins, winner: false, iconList: ["$value"]));
    }
    winnerRewardList.shuffle();

    update(["play"]);
  }

  List<int> _getRandomNumbersWithSet(int length) {
    Random random = Random();
    Set<int> numberSet = {};
    while (numberSet.length < length) {
      numberSet.add(random.nextInt(GameConfigHep.instance.getMaxLuckNumber()));
    }

    return numberSet.toList();
  }


  clickCheckCard(){
    // if(startScratch){
    //   return;
    // }
    // startScratch=true;


    print("kk===${winnerRewardList.length}");
  }

  onThreshold()async{
    key.currentState?.reveal();
    await Future.delayed(const Duration(milliseconds: 800));
    _checkResult();
  }

  _checkResult(){
    PlayedNumHep.instance.updatePlayedNum(winnerType);
    var totalReward = winnerRewardList.where((bean) => bean.winner).fold(0, (previousValue, element) => previousValue + element.rewardNum);
    if(totalReward<=0){
      RouterUtils.dialog(
        widget: NoWinDialog(
          dismiss: (){
            _reset();
          },
        ),
      );
      return;
    }
    if(_winnerBackBean.winType==WinType.diamond){
      var renderBox = diamondGlobalKey.currentContext!.findRenderObject() as RenderBox;
      var offset = renderBox.localToGlobal(Offset.zero);
      var endRenderBox = diamondEndGlobalKey.currentContext!.findRenderObject() as RenderBox;
      diamondEndOffset=endRenderBox.localToGlobal(Offset.zero);
      showDiamondAnimator=true;
      update(["diamond"]);
      diamondAnimation=Tween<Offset>(
        begin: offset,
        end: diamondEndOffset,
      ).animate(CurvedAnimation(parent: diamondLottieController, curve: Curves.elasticInOut));

      diamondLottieController..reset()..forward();
      return;
    }
    if(totalReward>=_winnerBackBean.bigWin){
      RouterUtils.dialog(
        widget: BigWinDialog(
          reward: totalReward,
          dismiss: (){
            _reset();
          },
        ),
      );
    }else{
      RouterUtils.dialog(
        widget: NormalWinDialog(
          reward: totalReward,
          dismiss: (){
            _reset();
          },
        ),
      );
    }
  }

  _reset()async{
    startScratch=false;
    _initWinnerBean();
    key.currentState?.reset();
    await UserInfoHep.instance.updateCanPlayNum(-1,winnerType);
    update(["num"]);
    var canPlay = await PlayedNumHep.instance.checkCanPlay(winnerType);
    if(!canPlay){
      RouterUtils.back();
    }
  }

  onScratchStart(){
    if(UserInfoHep.instance.getPlayNum(winnerType)<=0){
      RouterUtils.dialog(
          widget: AddChanceDialog(
            winnerType: winnerType,
          )
      );
      return;
    }
    startScratch=true;
  }

  onScratchEnd(){
    startScratch=false;
  }

  clickBack(){
    if(startScratch){
      return;
    }
    RouterUtils.back();
  }

  @override
  EventResult? initEventResult() => EventResult(
      call: (data){
        switch(data.code){
          case EventCode.updatePlayNumA:
            update(["num"]);
            break;
        }
      }
  );

  @override
  void onClose() {
    diamondLottieController.dispose();
    super.onClose();
  }
}