import 'package:ft_a/bean/home_list_bean.dart';
import 'package:ft_a/bean/played_num_bean.dart';
import 'package:ft_a/hep/game_config_hep.dart';
import 'package:ft_a/hep/hep.dart';
import 'package:ft_a/hep/played_num_hep.dart';
import 'package:ft_base/base/base_controller.dart';
import 'package:ft_base/routers/a_routers_name.dart';
import 'package:ft_base/routers/routers_utils.dart';
import 'package:ft_base/util/event/event_code.dart';
import 'package:ft_base/util/event/event_result.dart';

class CardsController extends BaseController{
  var chooseIndex=0;
  List<HomeListBean> homeList=[
    HomeListBean(uns: "list_uns1", sel: "list_sel1", center: "list1",numIcon: "num1",winnerType: WinnerType.winnerGame),
    HomeListBean(uns: "list_uns2", sel: "list_sel2", center: "list2",numIcon: "num2",winnerType: WinnerType.fruitMatch),
    HomeListBean(uns: "list_uns3", sel: "list_sel3", center: "list3",numIcon: "num3",winnerType: WinnerType.chasingLuck),
    HomeListBean(uns: "list_uns4", sel: "list_sel4", center: "list4",numIcon: "num4",winnerType: WinnerType.casinoRush),
    HomeListBean(uns: "list_uns5", sel: "list_sel5", center: "list5",numIcon: "num5",winnerType: WinnerType.winOrLose),
    HomeListBean(uns: "list_uns6", sel: "list_sel6", center: "list6",numIcon: "num6",winnerType: WinnerType.luckyNumber),
    HomeListBean(uns: "list_uns7", sel: "list_sel7", center: "list7",numIcon: "num7",winnerType: WinnerType.bettingHigh),
  ];

  clickItem(index){
    if(index==chooseIndex){
      return;
    }
    chooseIndex=index;
    update(["sel_list","center","num"]);
  }

  clickLeft(){
    if(chooseIndex<=0){
      return;
    }
    clickItem(chooseIndex-1);
  }

  clickRight(){
    if(chooseIndex>=homeList.length-1){
      return;
    }
    clickItem(chooseIndex+1);
  }

  toPlay()async{
    var bean = homeList[chooseIndex];
    var canPlay = await PlayedNumHep.instance.checkCanPlay(bean.winnerType);
    if(canPlay){
      Hep.toPlayPage(bean.winnerType);
    }
  }

  WinnerType getWinnerTypeByIndex() => WinnerType.values[chooseIndex];

  String getWinUpColor(){
    var bean = homeList[chooseIndex];
    switch(bean.winnerType){
      case WinnerType.winnerGame: return "#FF3333";
      // case WinnerType.fruitMatch:
      // case WinnerType.casinoRush:
      // case WinnerType.winOrLose:
      // case WinnerType.bettingHigh:
      // case WinnerType.chasingLuck: return "#FFF70F";
      default: return "#FFF70F";
    }
  }

  @override
  EventResult? initEventResult() => EventResult(
    call: (data){
      switch(data.code){
        case EventCode.updatePlayNumA:
          update(["num"]);
          break;
      }
    },
  );
}