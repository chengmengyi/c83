import 'dart:convert';
import 'dart:math';

import 'package:ft_a/bean/game_config_bean.dart';
import 'package:ft_a/bean/winner_back_bean.dart';
import 'package:ft_a/hep/local_data.dart';
import 'package:ft_base/util/util.dart';

enum WinnerType{
  winnerGame,fruitMatch,chasingLuck,casinoRush,winOrLose,luckyNumber,bettingHigh,
}

class GameConfigHep {
  static final GameConfigHep _instance=GameConfigHep();
  static GameConfigHep get instance =>_instance;

  GameConfigBean? _gameConfigBean;

  initData(){
    _gameConfigBean=GameConfigBean.fromJson(jsonDecode(gameConfigStr.base64()));
  }

  int getMaxWinUpNum(WinnerType winnerType){
    try{
      var indexWhere = WinnerType.values.indexWhere((element) => element==winnerType);
      if(indexWhere>=0){
        return (_gameConfigBean?.cardsRange??[])[indexWhere];
      }
      return 0;
    }catch(e){
      return 0;
    }
  }

  WinnerBackBean getWinnerBean(WinnerType winnerType){
    var bigWin=200,rewardNormal=100;
    List<RewardNumber> rewardNumberList=[];
    List<RewardMoney> rewardMoneyList=[];
    switch(winnerType){
      case WinnerType.winnerGame:
        var winnerGame = _gameConfigBean?.cardsWinnerGame;
        bigWin=winnerGame?.bigwinNumber??200;
        rewardNormal=winnerGame?.rewardNormal??100;
        rewardNumberList.addAll(winnerGame?.rewardNumber??[]);
        rewardMoneyList.addAll(winnerGame?.rewardMoney??[]);
        break;
      case WinnerType.fruitMatch:
        var winnerGame = _gameConfigBean?.cardsFruitMatch;
        bigWin=winnerGame?.bigwinNumber??200;
        rewardNormal=winnerGame?.rewardNormal??100;
        rewardNumberList.addAll(winnerGame?.rewardNumber??[]);
        rewardMoneyList.addAll(winnerGame?.rewardMoney??[]);
        break;
      case WinnerType.chasingLuck:
        var winnerGame = _gameConfigBean?.cardsChaseLucky;
        bigWin=winnerGame?.bigwinNumber??200;
        rewardNormal=winnerGame?.rewardNormal??100;
        rewardNumberList.addAll(winnerGame?.rewardNumber??[]);
        rewardMoneyList.addAll(winnerGame?.rewardMoney??[]);
        break;

      default:

        break;
    }
    if(rewardNumberList.isEmpty||rewardMoneyList.isEmpty){
      return WinnerBackBean(winNum: 0, bigWin: bigWin, coinsNum: 0, winType: WinType.coins,rewardNormal: rewardNormal);
    }
    var randomRewardMoney = _randomRewardMoney(rewardMoneyList);
    var randomRewardNumber = _randomRewardNumber(rewardNumberList);
    var winType = randomRewardMoney?.type==0?WinType.coins:WinType.diamond;
    if(randomRewardNumber?.number==0){
      return WinnerBackBean(winNum: 0, bigWin: bigWin, coinsNum: 0, winType: winType,rewardNormal: rewardNormal);
    }
    var winProbability = _getWinProbability(randomRewardMoney, rewardMoneyList);
    var coinsNum=(rewardNormal*winProbability*(randomRewardNumber?.number??0)).toInt();
    print("kk=====${randomRewardMoney}===${randomRewardNumber}====${rewardNormal}===${winProbability}====${coinsNum}");
    return WinnerBackBean(winNum: randomRewardNumber?.number??0, bigWin: bigWin, coinsNum: coinsNum, winType: winType,rewardNormal: rewardNormal);
  }

  RewardMoney? _randomRewardMoney(List<RewardMoney> list){
    if(list.isEmpty){
      return null;
    }
    var allScale = list.map((item) => item.scale).reduce((a, b) => (a??0) + (b??0))??0;
    int randomValue = Random().nextInt(allScale);
    int cumulativeProbability = 0;
    for (int i = 0; i < list.length; i++) {
      cumulativeProbability += list[i].scale??0;
      if (randomValue < cumulativeProbability) {
        return list[i];
      }
    }
    return list.first;
  }

  RewardNumber? _randomRewardNumber(List<RewardNumber> list){
    if(list.isEmpty){
      return null;
    }
    var allScale = list.map((item) => item.scale).reduce((a, b) => (a??0) + (b??0))??0;
    int randomValue = Random().nextInt(allScale);
    int cumulativeProbability = 0;
    for (int i = 0; i < list.length; i++) {
      cumulativeProbability += list[i].scale??0;
      if (randomValue < cumulativeProbability) {
        return list[i];
      }
    }
    return list.first;
  }

  double _getWinProbability(RewardMoney? rewardNumber,List<RewardMoney> list){
    var allScale = list.map((item) => item.scale).reduce((a, b) => (a??0) + (b??0))??0;
    if(allScale<=0){
      return 0.0;
    }
    return (rewardNumber?.scale??0)/allScale;
  }
}