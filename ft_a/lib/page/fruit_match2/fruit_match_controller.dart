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
import 'package:ft_base/base/base_controller.dart';
import 'package:ft_base/routers/routers_utils.dart';
import 'package:ft_base/util/event/event_code.dart';
import 'package:ft_base/util/event/event_result.dart';
import 'package:ft_base/util/util.dart';

class FruitMatchController extends BaseController with GetTickerProviderStateMixin{
  var startScratch=false,showDiamondAnimator=false,canPlay=true;
  WinnerType winnerType=WinnerType.fruitMatch;
  late WinnerBackBean _winnerBackBean;
  List<WinnerRewardBean> winnerRewardList=[];
  final key = GlobalKey<ScratcherState>();
  GlobalKey diamondGlobalKey=GlobalKey();
  GlobalKey diamondEndGlobalKey=GlobalKey();

  Offset diamondEndOffset=Offset.zero;
  late AnimationController diamondLottieController;
  Animation<Offset>? diamondAnimation;
  final List<String> _allIconList=["fruit3","fruit4","fruit5","fruit6"];

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
    if(_winnerBackBean.winNum>0){
      var rewardIcon = _allIconList.random();
      while(winnerRewardList.length<_winnerBackBean.winNum){
        winnerRewardList.add(WinnerRewardBean(rewardNum: _winnerBackBean.coinsNum, winType: _winnerBackBean.winType, winner: true, iconList: [rewardIcon]));
      }
      var newList = List.from(_allIconList);
      newList.remove(rewardIcon);
      var randomIcon = newList.random();
      while(winnerRewardList.length<6){
        winnerRewardList.add(WinnerRewardBean(rewardNum: Random().nextInt(_winnerBackBean.rewardNormal), winType: WinType.coins, winner: false, iconList: [randomIcon]));
      }
    }else{
      var randomElements = getRandomElements(3);
      for (var value in randomElements) {
        winnerRewardList.add(WinnerRewardBean(rewardNum: Random().nextInt(_winnerBackBean.rewardNormal), winType: WinType.coins, winner: false, iconList: [value]));
      }
      while(winnerRewardList.length<6){
        winnerRewardList.add(WinnerRewardBean(rewardNum: Random().nextInt(_winnerBackBean.rewardNormal), winType: WinType.coins, winner: false, iconList: [randomElements.last]));
      }
    }
    update(["play"]);
  }

  String getRewardIcon(){
    if(_winnerBackBean.winNum>0){
      var indexWhere = winnerRewardList.indexWhere((element) => element.winner);
      if(indexWhere>=0){
        return winnerRewardList[indexWhere].iconList.first;
      }else{
        return "fruit3";
      }
    }else{
      var newList = List.from(_allIconList);
      for (var value in winnerRewardList) {
        var first = value.iconList.first;
        if(newList.contains(first)){
          newList.remove(first);
        }
      }
      if(newList.isNotEmpty){
        return newList.first;
      }
      return "fruit3";
    }
  }

  List<String> getRandomElements(int count) {
    final random = Random();
    List<String> result = [];
    final remaining = List.from(_allIconList);

    while (result.length < count && remaining.isNotEmpty) {
      final index = random.nextInt(remaining.length);
      result.add(remaining[index]);
      remaining.removeAt(index);
    }

    return result;
  }

  clickCheckCard()async{
    if(startScratch){
      return;
    }
    startScratch=true;
    if(canPlay){

    }else{
      if(!await PlayedNumHep.instance.checkHasNextPlay(winnerType)){
        RouterUtils.back();
      }
    }
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
    canPlay = await PlayedNumHep.instance.checkCanPlay(winnerType);
    if(!canPlay){
      update(["check_btn"]);
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