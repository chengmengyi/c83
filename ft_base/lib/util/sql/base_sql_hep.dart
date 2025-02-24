import 'package:ft_base/util/sql/sql_table_name.dart';
import 'package:sqflite/sqflite.dart';

class BaseSqlHep{
  static final BaseSqlHep _instance = BaseSqlHep();
  static BaseSqlHep get instance => _instance;


  Future<Database> initSql()async{
    var database = await openDatabase(
        "ft.db",
        version: 1,
        onCreate: (db,version)async{
          db.execute('CREATE TABLE ${SqlTableName.userInfoA} (id INTEGER PRIMARY KEY AUTOINCREMENT, coinsNum INTEGER, diamondNum INTEGER, winnerGamePlayNum INTEGER, fruitMatchPlayNum INTEGER, chasingLuckPlayNum INTEGER, casinoRushPlayNum INTEGER, winOrLosePlayNum INTEGER, luckyNumberPlayNum INTEGER, bettingHighPlayNum INTEGER)');
          db.execute('CREATE TABLE ${SqlTableName.playedNumA} (id INTEGER PRIMARY KEY AUTOINCREMENT, playedNum INTEGER, startTime INTEGER, gameType TEXT)');
        },
        // onUpgrade: (db,oldVersion,newVersion){
        //   if(newVersion==2){
        //     _createVersion2DB(db);
        //   }
        // }
    );
    return database;
  }
}