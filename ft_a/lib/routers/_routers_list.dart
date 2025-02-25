import 'package:ft_a/page/betting_high7/betting_high_page.dart';
import 'package:ft_a/page/casino_rush4/casino_rush_page.dart';
import 'package:ft_a/page/chasing_luck3/chasing_luck_page.dart';
import 'package:ft_a/page/fruit_match2/fruit_match_page.dart';
import 'package:ft_a/page/home/home_page.dart';
import 'package:ft_a/page/luck_number6/luck_number_page.dart';
import 'package:ft_a/page/win_or_lose5/win_or_lose_page.dart';
import 'package:ft_a/page/winner_game1/winner_game_page.dart';
import 'package:ft_base/routers/a_routers_name.dart';
import 'package:ft_base/util/util.dart';

class ARoutersList{
  static final aList=[
    GetPage(
        name: ARoutersName.home,
        page: ()=> HomePage(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: ARoutersName.winnerGame,
        page: ()=> WinnerGamePage(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: ARoutersName.fruitMatch,
        page: ()=> FruitMatchPage(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: ARoutersName.chasingLuck,
        page: ()=> ChasingLuckPage(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: ARoutersName.casinoRush,
        page: ()=> CasinoRushPage(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: ARoutersName.winOrLose,
        page: ()=> WinOrLosePage(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: ARoutersName.luckNumber,
        page: ()=> LuckNumberPage(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: ARoutersName.bettingHigh,
        page: ()=> BettingHighPage(),
        transition: Transition.fadeIn
    ),
  ];
}