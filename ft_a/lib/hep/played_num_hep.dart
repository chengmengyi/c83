import 'package:flutter/foundation.dart';
import 'package:ft_a/bean/played_num_bean.dart';
import 'package:ft_a/hep/game_config_hep.dart';
import 'package:ft_base/util/event/event_code.dart';
import 'package:ft_base/util/event/event_data.dart';
import 'package:ft_base/util/sql/base_sql_hep.dart';
import 'package:ft_base/util/sql/sql_table_name.dart';
import 'package:ft_base/util/util.dart';
import 'package:sqflite_common/sqlite_api.dart';

class PlayedNumHep {
  static final PlayedNumHep _instance=PlayedNumHep();
  static PlayedNumHep get instance=>_instance;

  // Future<List<PlayedNumBean>> checkPlayedInfo()async{
  //   var sql = await BaseSqlHep.instance.initSql();
  //   var list = await sql.query(SqlTableName.playedNumA);
  //   if(list.isEmpty){
  //     return [];
  //   }
  //   List<PlayedNumBean> resultList=[];
  //   for (var value in list) {
  //     resultList.add(PlayedNumBean.fromJson(value));
  //   }
  //   return resultList;
  // }

  updatePlayedNum(WinnerType winnerType)async{
    var sql = await BaseSqlHep.instance.initSql();
    var list = await sql.query(SqlTableName.playedNumA,where: '"gameType" = ?',whereArgs: [winnerType.name]);
    if(list.isEmpty){
      await sql.insert(SqlTableName.playedNumA, {"playedNum":1,"startTime":DateTime.now().millisecondsSinceEpoch,"gameType":winnerType.name});
      return;
    }
    var newMap = Map<String, Object?>.from(list.first);
    var playedNum = newMap["playedNum"] as int ;
    newMap["playedNum"]=playedNum+1;
    newMap["startTime"]=DateTime.now().millisecondsSinceEpoch;
    await sql.update(SqlTableName.playedNumA, newMap,where: '"id" = ? ',whereArgs: [newMap["id"]]);
  }

  Future<bool> checkCanPlay(WinnerType winnerType)async{
    if(kDebugMode){
      return true;
    }
    var sql = await BaseSqlHep.instance.initSql();
    var list = await sql.query(SqlTableName.playedNumA,where: '"gameType" = ?',whereArgs: [winnerType.name]);
    if(list.isEmpty){
      return true;
    }
    var newMap = Map<String, Object?>.from(list.first);
    var playedNum = newMap["playedNum"] as int ;
    if(playedNum>=10){
      var startTime = newMap["startTime"] as int ;
      var time = DateTime.now().millisecondsSinceEpoch-startTime;
      if(time>3600000){
        newMap["playedNum"]=0;
        newMap["startTime"]=DateTime.now().millisecondsSinceEpoch;
        await sql.update(SqlTableName.playedNumA, newMap,where: '"id" = ? ',whereArgs: [newMap["id"]]);
        return true;
      }
      showToast("No scratch card, please go to the next level！");
      return false;
    }
    return true;
  }
}