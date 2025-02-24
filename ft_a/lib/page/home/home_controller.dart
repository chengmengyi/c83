import 'package:flutter/material.dart';
import 'package:ft_a/bean/home_bottom_bean.dart';
import 'package:ft_a/page/home/ach/ach_child.dart';
import 'package:ft_a/page/home/cards/cards_child.dart';
import 'package:ft_base/base/base_controller.dart';
class HomeController extends BaseController{
  var chooseIndex=0;
  List<HomeBottomBean> list=[
    HomeBottomBean(uns: "card_uns", sel: "card_sel", text: "Cards"),
    HomeBottomBean(uns: "ach_uns", sel: "ach_sel", text: "Achieve"),
  ];
  List<Widget> pageList=[CardsChild(),AchChild()];

  clickBottom(index){
    if(chooseIndex==index){
      return;
    }
    chooseIndex=index;
    update(["page"]);
  }
}