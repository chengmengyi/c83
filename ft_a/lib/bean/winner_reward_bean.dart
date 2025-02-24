import 'package:ft_a/bean/winner_back_bean.dart';

class WinnerRewardBean{
  int rewardNum;
  WinType winType;
  bool winner;
  List<String> iconList;
  WinnerRewardBean({
    required this.rewardNum,
    required this.winType,
    required this.winner,
    required this.iconList,
});

  @override
  String toString() {
    return 'WinnerRewardBean{rewardNum: $rewardNum, winType: $winType, winner: $winner, iconList: $iconList}';
  }
}
