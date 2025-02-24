class UserInfoBean {
  UserInfoBean({
      this.coinsNum, 
      this.diamondNum, 
      this.winnerGamePlayNum,
      this.fruitMatchPlayNum,
      this.chasingLuckPlayNum,
      this.casinoRushPlayNum,
      this.winOrLosePlayNum,
      this.luckyNumberPlayNum,
      this.bettingHighPlayNum,
  });

  UserInfoBean.fromJson(dynamic json) {
    id = json['id'];
    coinsNum = json['coinsNum'];
    diamondNum = json['diamondNum'];
    winnerGamePlayNum = json['winnerGamePlayNum'];
    fruitMatchPlayNum = json['fruitMatchPlayNum'];
    chasingLuckPlayNum = json['chasingLuckPlayNum'];
    casinoRushPlayNum = json['casinoRushPlayNum'];
    winOrLosePlayNum = json['winOrLosePlayNum'];
    luckyNumberPlayNum = json['luckyNumberPlayNum'];
    bettingHighPlayNum = json['bettingHighPlayNum'];
  }
  int? id;
  int? coinsNum;
  int? diamondNum;
  int? winnerGamePlayNum;
  int? fruitMatchPlayNum;
  int? chasingLuckPlayNum;
  int? casinoRushPlayNum;
  int? winOrLosePlayNum;
  int? luckyNumberPlayNum;
  int? bettingHighPlayNum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coinsNum'] = coinsNum;
    map['diamondNum'] = diamondNum;
    map['winnerGamePlayNum'] = winnerGamePlayNum;
    map['fruitMatchPlayNum'] = fruitMatchPlayNum;
    map['chasingLuckPlayNum'] = chasingLuckPlayNum;
    map['casinoRushPlayNum'] = casinoRushPlayNum;
    map['winOrLosePlayNum'] = winOrLosePlayNum;
    map['luckyNumberPlayNum'] = luckyNumberPlayNum;
    map['bettingHighPlayNum'] = bettingHighPlayNum;
    return map;
  }

}