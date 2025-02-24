class PlayedNumBean {
  PlayedNumBean({
      this.playedNum, 
      this.startTime, 
      this.gameType,});

  PlayedNumBean.fromJson(dynamic json) {
    playedNum = json['playedNum'];
    startTime = json['startTime'];
    gameType = json['gameType'];
  }
  int? playedNum;
  int? startTime;
  String? gameType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['playedNum'] = playedNum;
    map['startTime'] = startTime;
    map['gameType'] = gameType;
    return map;
  }

}