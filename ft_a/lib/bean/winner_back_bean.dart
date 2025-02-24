enum WinType{
  coins,diamond,
}

class WinnerBackBean{
  int winNum;
  int bigWin;
  int coinsNum;
  int rewardNormal;
  WinType winType;
  WinnerBackBean({
    required this.winNum,
    required this.bigWin,
    required this.coinsNum,
    required this.winType,
    required this.rewardNormal,
});

  @override
  String toString() {
    return 'WinnerBackBean{winNum: $winNum, bigWin: $bigWin, coinsNum: $coinsNum, winType: $winType}';
  }
}