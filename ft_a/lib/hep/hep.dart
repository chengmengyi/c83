import 'package:ft_a/hep/game_config_hep.dart';
import 'package:ft_base/routers/a_routers_name.dart';
import 'package:ft_base/routers/routers_utils.dart';

class Hep{
  static toPlayPage(WinnerType winnerType,{bool offCurrentPage=false}){
    String routerName="";
    switch(winnerType){
      case WinnerType.winnerGame:
        routerName=ARoutersName.winnerGame;
        break;
      case WinnerType.fruitMatch:
        routerName=ARoutersName.fruitMatch;
        break;
      case WinnerType.chasingLuck:
        routerName=ARoutersName.chasingLuck;
        break;
      case WinnerType.casinoRush:
        routerName=ARoutersName.casinoRush;
        break;
      case WinnerType.winOrLose:
        routerName=ARoutersName.winOrLose;
        break;
      case WinnerType.luckyNumber:
        routerName=ARoutersName.luckNumber;
        break;
      case WinnerType.bettingHigh:
        routerName=ARoutersName.bettingHigh;
        break;
      default:

        break;
    }
    if(offCurrentPage){
      RouterUtils.offNamed(routersName: routerName);
    }else{
      RouterUtils.toNamed(routersName: routerName);
    }
  }
}