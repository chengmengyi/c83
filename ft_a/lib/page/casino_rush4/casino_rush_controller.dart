import 'package:ft_a/hep/auto_scratch.dart';
import 'package:ft_base/base/base_controller.dart';
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
import 'package:ft_base/util/util.dart';

class CasinoRushController extends BaseController with GetTickerProviderStateMixin{
  var startScratch=false,showDiamondAnimator=false,canPlay=true;
  WinnerType winnerType=WinnerType.casinoRush;
  late WinnerBackBean _winnerBackBean;
  List<WinnerRewardBean> winnerRewardList=[];
  final key = GlobalKey<ScratcherState>();
  GlobalKey diamondGlobalKey=GlobalKey();
  GlobalKey diamondEndGlobalKey=GlobalKey();

  Offset diamondEndOffset=Offset.zero;
  late AnimationController diamondLottieController;
  Animation<Offset>? diamondAnimation;
  final List<String> _allIconList=["rush3","rush4","rush5"];

  Offset? iconOffset;
  AutoScratch? autoScratch;

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
    autoScratch=AutoScratch(key);
  }

  _initWinnerBean(){
    _winnerBackBean = GameConfigHep.instance.getWinnerBean(winnerType);
    winnerRewardList.clear();
    if(_winnerBackBean.winNum>0){
      while(winnerRewardList.length<_winnerBackBean.winNum){
        winnerRewardList.add(WinnerRewardBean(rewardNum: _winnerBackBean.coinsNum, winType: _winnerBackBean.winType, winner: true, iconList: _generateWinList()));
      }
      while(winnerRewardList.length<4){
        winnerRewardList.add(WinnerRewardBean(rewardNum: Random().nextInt(_winnerBackBean.rewardNormal), winType: WinType.coins, winner: false, iconList: _generateNoWinList()));
      }
    }else{
      while(winnerRewardList.length<4){
        winnerRewardList.add(WinnerRewardBean(rewardNum: Random().nextInt(_winnerBackBean.rewardNormal), winType: WinType.coins, winner: false, iconList: _generateNoWinList()));
      }
    }
    update(["play"]);
  }

  List<String> _generateWinList() {
    Random random = Random();
    List<String> result = List.filled(9, '');
    int lineType = random.nextInt(8);
    switch (lineType) {
      case 0:
        result[0] = result[1] = result[2] = 'rush3';
        break;
      case 1:
        result[3] = result[4] = result[5] = 'rush3';
        break;
      case 2:
        result[6] = result[7] = result[8] = 'rush3';
        break;
      case 3:
        result[0] = result[3] = result[6] = 'rush3';
        break;
      case 4:
        result[1] = result[4] = result[7] = 'rush3';
        break;
      case 5:
        result[2] = result[5] = result[8] = 'rush3';
        break;
      case 6:
        result[0] = result[4] = result[8] = 'rush3';
        break;
      case 7:
        result[2] = result[4] = result[6] = 'rush3';
        break;
    }

    List<int> availablePositions = [];
    for (int i = 0; i < 9; i++) {
      if (result[i].isEmpty) {
        availablePositions.add(i);
      }
    }

    List<String> remainingElements = ['rush4', 'rush5'];
    while (availablePositions.isNotEmpty) {
      List<String> validChoices = [];
      for (String element in remainingElements) {
        bool isValid = true;
        for (int position in availablePositions) {
          result[position] = element;
          if (!_isValidExcludingRush2(result)) {
            isValid = false;
          }
          result[position] = '';
        }
        if (isValid) {
          validChoices.add(element);
        }
      }

      if (validChoices.isNotEmpty) {
        String chosenElement = validChoices[random.nextInt(validChoices.length)];
        int chosenPosition = availablePositions[random.nextInt(availablePositions.length)];
        result[chosenPosition] = chosenElement;
        availablePositions.remove(chosenPosition);
      } else {
        return _generateWinList();
      }
    }
    return result;
  }

  bool _isValidExcludingRush2(List<String> list) {
    // 检查行
    for (int i = 0; i < 3; i++) {
      int startIndex = i * 3;
      String first = list[startIndex];
      if (first != 'rush3' && first == list[startIndex + 1] && list[startIndex + 1] == list[startIndex + 2]) {
        return false;
      }
    }

    // 检查列
    for (int i = 0; i < 3; i++) {
      String first = list[i];
      if (first != 'rush3' && first == list[i + 3] && list[i + 3] == list[i + 6]) {
        return false;
      }
    }

    // 检查对角线
    String topLeft = list[0];
    if (topLeft != 'rush3' && topLeft == list[4] && list[4] == list[8]) {
      return false;
    }
    String topRight = list[2];
    if (topRight != 'rush3' && topRight == list[4] && list[4] == list[6]) {
      return false;
    }
    return true;
  }

  List<String> _generateNoWinList() {
    Random random = Random();
    List<String> result;

    while (true) {
      result = [];
      for (int i = 0; i < 9; i++) {
        int randomIndex = random.nextInt(_allIconList.length);
        result.add(_allIconList[randomIndex]);
      }

      if (_isValid(result)) {
        break;
      }
    }

    return result;
  }

  bool _isValid(List<String> list) {
    for (int i = 0; i < 3; i++) {
      int startIndex = i * 3;
      if (list[startIndex] == list[startIndex + 1] && list[startIndex + 1] == list[startIndex + 2]) {
        return false;
      }
    }
    for (int i = 0; i < 3; i++) {
      if (list[i] == list[i + 3] && list[i + 3] == list[i + 6]) {
        return false;
      }
    }
    if (list[0] == list[4] && list[4] == list[8]) {
      return false;
    }
    if (list[2] == list[4] && list[4] == list[6]) {
      return false;
    }

    return true;
  }

  clickCheckCard()async{
    if(startScratch){
      return;
    }
    if(UserInfoHep.instance.getPlayNum(winnerType)<=0){
      RouterUtils.dialog(
          widget: AddChanceDialog(
            winnerType: winnerType,
          )
      );
      return;
    }
    startScratch=true;
    if(canPlay){
      autoScratch?.startAuto(
        key: key,
        iconOffsetCall: (offset){
          iconOffset=offset;
          update(["gold_icon"]);
        },
      );
    }else{
      if(!await PlayedNumHep.instance.checkHasNextPlay(winnerType)){
        RouterUtils.back();
      }
    }
  }

  onThreshold()async{
    autoScratch?.stopWhile=true;
    Future.delayed(const Duration(milliseconds: 100),(){
      iconOffset=null;
      update(["gold_icon"]);
    });
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
    autoScratch?.stopWhile=false;
    iconOffset=null;
    update(["gold_icon"]);
    await UserInfoHep.instance.updateCanPlayNum(-1,winnerType);
    update(["num"]);
    canPlay = await PlayedNumHep.instance.checkCanPlay(winnerType);
    if(!canPlay){
      update(["check_btn"]);
    }
  }


  updateIconOffset(DragUpdateDetails details){
    var offset = details.localPosition;
    iconOffset=Offset(offset.dx+(autoScratch?.marginLeft??0), offset.dy+(autoScratch?.marginTop??0));
    update(["gold_icon"]);
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