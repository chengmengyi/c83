import 'package:ft_a/bean/user_info_bean.dart';
import 'package:ft_a/hep/game_config_hep.dart';
import 'package:ft_base/util/event/event_code.dart';
import 'package:ft_base/util/event/event_data.dart';
import 'package:ft_base/util/sql/base_sql_hep.dart';
import 'package:ft_base/util/sql/sql_table_name.dart';
import 'package:ft_base/util/util.dart';

class UserInfoHep{
  static final UserInfoHep _instance = UserInfoHep();
  static UserInfoHep get instance => _instance;

  UserInfoBean? _userInfoBean;

  initUserInfo()async{
    var db = await BaseSqlHep.instance.initSql();
    var list = await db.query(SqlTableName.userInfoA);
    if(list.isEmpty){
      _userInfoBean=UserInfoBean(coinsNum: 0,diamondNum: 0,winnerGamePlayNum: 3,fruitMatchPlayNum: 3,chasingLuckPlayNum: 3,casinoRushPlayNum: 3,winOrLosePlayNum: 3,luckyNumberPlayNum: 3,bettingHighPlayNum: 3,);
      var id = await db.insert(SqlTableName.userInfoA, _userInfoBean?.toJson()??{});
      _userInfoBean?.id=id;
      return;
    }
    _userInfoBean=UserInfoBean.fromJson(list.first);
  }

  updateUserCoins(int coins){
    var coinsNum = _userInfoBean?.coinsNum??0;
    _userInfoBean?.coinsNum=coinsNum+coins;
    EventData(code: EventCode.updateUserCoinsA).send();
  }

  updateUserDiamond(int add)async{
    var diamondNum = _userInfoBean?.diamondNum??0;
    var lastLevel = diamondNum~/3;
    _userInfoBean?.diamondNum=diamondNum+add;
    await _saveUserInfo();
    EventData(code: EventCode.updateUserDiamondA).send();
    var nowLevel = (_userInfoBean?.diamondNum??0)~/3;
    if(nowLevel>lastLevel){
      EventData(code: EventCode.showLevelFingerA).send();
    }
  }

  int getUserDiamond()=>_userInfoBean?.diamondNum??0;

  int getUserCoins()=>_userInfoBean?.coinsNum??0;

  int getPlayNum(WinnerType winnerType){
    switch(winnerType){
      case WinnerType.winnerGame: return _userInfoBean?.winnerGamePlayNum??0;
      case WinnerType.fruitMatch: return _userInfoBean?.fruitMatchPlayNum??0;
      case WinnerType.chasingLuck: return _userInfoBean?.chasingLuckPlayNum??0;
      case WinnerType.casinoRush: return _userInfoBean?.casinoRushPlayNum??0;
      case WinnerType.winOrLose: return _userInfoBean?.winOrLosePlayNum??0;
      case WinnerType.luckyNumber: return _userInfoBean?.luckyNumberPlayNum??0;
      case WinnerType.bettingHigh: return _userInfoBean?.bettingHighPlayNum??0;
      default: return 0;
    }
  }

  updateCanPlayNum(int num,WinnerType winnerType,{bool fromVideo=false})async{
    var coinsNum = _userInfoBean?.coinsNum??0;
    if(num>0&&!fromVideo){
      if(coinsNum<num*1000){
        showToast("Your gold coins are insufficient");
        return;
      }
      _userInfoBean?.coinsNum=coinsNum-num*1000;
    }
    switch(winnerType){
      case WinnerType.winnerGame:
        _userInfoBean?.winnerGamePlayNum=(_userInfoBean?.winnerGamePlayNum??0)+num;
        if((_userInfoBean?.winnerGamePlayNum??0)<0){
          _userInfoBean?.winnerGamePlayNum=0;
        }
        break;
      case WinnerType.fruitMatch:
        _userInfoBean?.fruitMatchPlayNum=(_userInfoBean?.fruitMatchPlayNum??0)+num;
        if((_userInfoBean?.fruitMatchPlayNum??0)<0){
          _userInfoBean?.fruitMatchPlayNum=0;
        }
        break;
      case WinnerType.chasingLuck:
        _userInfoBean?.chasingLuckPlayNum=(_userInfoBean?.chasingLuckPlayNum??0)+num;
        if((_userInfoBean?.chasingLuckPlayNum??0)<0){
          _userInfoBean?.chasingLuckPlayNum=0;
        }
        break;
      case WinnerType.casinoRush:
        _userInfoBean?.casinoRushPlayNum=(_userInfoBean?.casinoRushPlayNum??0)+num;
        if((_userInfoBean?.casinoRushPlayNum??0)<0){
          _userInfoBean?.casinoRushPlayNum=0;
        }
        break;
      case WinnerType.winOrLose:
        _userInfoBean?.winOrLosePlayNum=(_userInfoBean?.winOrLosePlayNum??0)+num;
        if((_userInfoBean?.winOrLosePlayNum??0)<0){
          _userInfoBean?.winOrLosePlayNum=0;
        }
        break;
      case WinnerType.luckyNumber:
        _userInfoBean?.luckyNumberPlayNum=(_userInfoBean?.luckyNumberPlayNum??0)+num;
        if((_userInfoBean?.luckyNumberPlayNum??0)<0){
          _userInfoBean?.luckyNumberPlayNum=0;
        }
        break;
      case WinnerType.bettingHigh:
        _userInfoBean?.bettingHighPlayNum=(_userInfoBean?.bettingHighPlayNum??0)+num;
        if((_userInfoBean?.bettingHighPlayNum??0)<0){
          _userInfoBean?.bettingHighPlayNum=0;
        }
        break;
      default:

        break;
    }
    await _saveUserInfo();
    EventData(code: EventCode.updatePlayNumA).send();
    if(!fromVideo){
      EventData(code: EventCode.updateUserCoinsA).send();
    }
  }

  _saveUserInfo()async{
    var db = await BaseSqlHep.instance.initSql();
    await db.update(SqlTableName.userInfoA, _userInfoBean?.toJson()??{},where: '"id" = ?', whereArgs: [_userInfoBean?.id]);
  }


}