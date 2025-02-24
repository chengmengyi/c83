class GameConfigBean {
  GameConfigBean({
      this.cardsRange, 
      this.cardsWinnerGame, 
      this.cardsFruitMatch, 
      this.cardsChaseLucky, 
      this.cardsCasinoRush, 
      this.cardsWinLose, 
      this.cardsLuckyNumber, 
      this.cardsBettingHigh,});

  GameConfigBean.fromJson(dynamic json) {
    cardsRange = json['cards_range'] != null ? json['cards_range'].cast<int>() : [];
    cardsWinnerGame = json['cards_winner_game'] != null ? CardsWinnerGame.fromJson(json['cards_winner_game']) : null;
    cardsFruitMatch = json['cards_fruit_match'] != null ? CardsFruitMatch.fromJson(json['cards_fruit_match']) : null;
    cardsChaseLucky = json['cards_chase_lucky'] != null ? CardsChaseLucky.fromJson(json['cards_chase_lucky']) : null;
    cardsCasinoRush = json['cards_casino_rush'] != null ? CardsCasinoRush.fromJson(json['cards_casino_rush']) : null;
    cardsWinLose = json['cards_win_lose'] != null ? CardsWinLose.fromJson(json['cards_win_lose']) : null;
    cardsLuckyNumber = json['cards_lucky_number'] != null ? CardsLuckyNumber.fromJson(json['cards_lucky_number']) : null;
    cardsBettingHigh = json['cards_betting_high'] != null ? CardsBettingHigh.fromJson(json['cards_betting_high']) : null;
  }
  List<int>? cardsRange;
  CardsWinnerGame? cardsWinnerGame;
  CardsFruitMatch? cardsFruitMatch;
  CardsChaseLucky? cardsChaseLucky;
  CardsCasinoRush? cardsCasinoRush;
  CardsWinLose? cardsWinLose;
  CardsLuckyNumber? cardsLuckyNumber;
  CardsBettingHigh? cardsBettingHigh;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cards_range'] = cardsRange;
    if (cardsWinnerGame != null) {
      map['cards_winner_game'] = cardsWinnerGame?.toJson();
    }
    if (cardsFruitMatch != null) {
      map['cards_fruit_match'] = cardsFruitMatch?.toJson();
    }
    if (cardsChaseLucky != null) {
      map['cards_chase_lucky'] = cardsChaseLucky?.toJson();
    }
    if (cardsCasinoRush != null) {
      map['cards_casino_rush'] = cardsCasinoRush?.toJson();
    }
    if (cardsWinLose != null) {
      map['cards_win_lose'] = cardsWinLose?.toJson();
    }
    if (cardsLuckyNumber != null) {
      map['cards_lucky_number'] = cardsLuckyNumber?.toJson();
    }
    if (cardsBettingHigh != null) {
      map['cards_betting_high'] = cardsBettingHigh?.toJson();
    }
    return map;
  }

}

class CardsBettingHigh {
  CardsBettingHigh({
      this.maxNumber, 
      this.rewardNormal, 
      this.bigwinNumber, 
      this.rewardNumber, 
      this.rewardMoney,});

  CardsBettingHigh.fromJson(dynamic json) {
    maxNumber = json['max_number'];
    rewardNormal = json['reward_normal'];
    bigwinNumber = json['bigwin_number'];
    if (json['reward_number'] != null) {
      rewardNumber = [];
      json['reward_number'].forEach((v) {
        rewardNumber?.add(RewardNumber.fromJson(v));
      });
    }
    if (json['reward_money'] != null) {
      rewardMoney = [];
      json['reward_money'].forEach((v) {
        rewardMoney?.add(RewardMoney.fromJson(v));
      });
    }
  }
  int? maxNumber;
  int? rewardNormal;
  int? bigwinNumber;
  List<RewardNumber>? rewardNumber;
  List<RewardMoney>? rewardMoney;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['max_number'] = maxNumber;
    map['reward_normal'] = rewardNormal;
    map['bigwin_number'] = bigwinNumber;
    if (rewardNumber != null) {
      map['reward_number'] = rewardNumber?.map((v) => v.toJson()).toList();
    }
    if (rewardMoney != null) {
      map['reward_money'] = rewardMoney?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class RewardMoney {
  RewardMoney({
      this.type, 
      this.scale,});

  RewardMoney.fromJson(dynamic json) {
    type = json['type'];
    scale = json['scale'];
  }
  int? type;
  int? scale;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['scale'] = scale;
    return map;
  }

  @override
  String toString() {
    return 'RewardMoney{type: $type, scale: $scale}';
  }
}

class RewardNumber {
  RewardNumber({
      this.number, 
      this.scale,});

  RewardNumber.fromJson(dynamic json) {
    number = json['number'];
    scale = json['scale'];
  }
  int? number;
  int? scale;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['number'] = number;
    map['scale'] = scale;
    return map;
  }

  @override
  String toString() {
    return 'RewardNumber{number: $number, scale: $scale}';
  }
}

class CardsLuckyNumber {
  CardsLuckyNumber({
      this.maxNumber, 
      this.rewardNormal, 
      this.bigwinNumber, 
      this.rewardNumber, 
      this.rewardMoney,});

  CardsLuckyNumber.fromJson(dynamic json) {
    maxNumber = json['max_number'];
    rewardNormal = json['reward_normal'];
    bigwinNumber = json['bigwin_number'];
    if (json['reward_number'] != null) {
      rewardNumber = [];
      json['reward_number'].forEach((v) {
        rewardNumber?.add(RewardNumber.fromJson(v));
      });
    }
    if (json['reward_money'] != null) {
      rewardMoney = [];
      json['reward_money'].forEach((v) {
        rewardMoney?.add(RewardMoney.fromJson(v));
      });
    }
  }
  int? maxNumber;
  int? rewardNormal;
  int? bigwinNumber;
  List<RewardNumber>? rewardNumber;
  List<RewardMoney>? rewardMoney;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['max_number'] = maxNumber;
    map['reward_normal'] = rewardNormal;
    map['bigwin_number'] = bigwinNumber;
    if (rewardNumber != null) {
      map['reward_number'] = rewardNumber?.map((v) => v.toJson()).toList();
    }
    if (rewardMoney != null) {
      map['reward_money'] = rewardMoney?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
class CardsWinLose {
  CardsWinLose({
      this.rewardNormal, 
      this.bigwinNumber, 
      this.rewardNumber, 
      this.rewardMoney,});

  CardsWinLose.fromJson(dynamic json) {
    rewardNormal = json['reward_normal'];
    bigwinNumber = json['bigwin_number'];
    if (json['reward_number'] != null) {
      rewardNumber = [];
      json['reward_number'].forEach((v) {
        rewardNumber?.add(RewardNumber.fromJson(v));
      });
    }
    if (json['reward_money'] != null) {
      rewardMoney = [];
      json['reward_money'].forEach((v) {
        rewardMoney?.add(RewardMoney.fromJson(v));
      });
    }
  }
  int? rewardNormal;
  int? bigwinNumber;
  List<RewardNumber>? rewardNumber;
  List<RewardMoney>? rewardMoney;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reward_normal'] = rewardNormal;
    map['bigwin_number'] = bigwinNumber;
    if (rewardNumber != null) {
      map['reward_number'] = rewardNumber?.map((v) => v.toJson()).toList();
    }
    if (rewardMoney != null) {
      map['reward_money'] = rewardMoney?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class CardsCasinoRush {
  CardsCasinoRush({
      this.rewardNormal, 
      this.bigwinNumber, 
      this.rewardNumber, 
      this.rewardMoney,});

  CardsCasinoRush.fromJson(dynamic json) {
    rewardNormal = json['reward_normal'];
    bigwinNumber = json['bigwin_number'];
    if (json['reward_number'] != null) {
      rewardNumber = [];
      json['reward_number'].forEach((v) {
        rewardNumber?.add(RewardNumber.fromJson(v));
      });
    }
    if (json['reward_money'] != null) {
      rewardMoney = [];
      json['reward_money'].forEach((v) {
        rewardMoney?.add(RewardMoney.fromJson(v));
      });
    }
  }
  int? rewardNormal;
  int? bigwinNumber;
  List<RewardNumber>? rewardNumber;
  List<RewardMoney>? rewardMoney;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reward_normal'] = rewardNormal;
    map['bigwin_number'] = bigwinNumber;
    if (rewardNumber != null) {
      map['reward_number'] = rewardNumber?.map((v) => v.toJson()).toList();
    }
    if (rewardMoney != null) {
      map['reward_money'] = rewardMoney?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class CardsChaseLucky {
  CardsChaseLucky({
      this.rewardNormal, 
      this.bigwinNumber, 
      this.rewardNumber, 
      this.rewardMoney,});

  CardsChaseLucky.fromJson(dynamic json) {
    rewardNormal = json['reward_normal'];
    bigwinNumber = json['bigwin_number'];
    if (json['reward_number'] != null) {
      rewardNumber = [];
      json['reward_number'].forEach((v) {
        rewardNumber?.add(RewardNumber.fromJson(v));
      });
    }
    if (json['reward_money'] != null) {
      rewardMoney = [];
      json['reward_money'].forEach((v) {
        rewardMoney?.add(RewardMoney.fromJson(v));
      });
    }
  }
  int? rewardNormal;
  int? bigwinNumber;
  List<RewardNumber>? rewardNumber;
  List<RewardMoney>? rewardMoney;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reward_normal'] = rewardNormal;
    map['bigwin_number'] = bigwinNumber;
    if (rewardNumber != null) {
      map['reward_number'] = rewardNumber?.map((v) => v.toJson()).toList();
    }
    if (rewardMoney != null) {
      map['reward_money'] = rewardMoney?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class CardsFruitMatch {
  CardsFruitMatch({
      this.rewardNormal, 
      this.bigwinNumber, 
      this.rewardNumber, 
      this.rewardMoney,});

  CardsFruitMatch.fromJson(dynamic json) {
    rewardNormal = json['reward_normal'];
    bigwinNumber = json['bigwin_number'];
    if (json['reward_number'] != null) {
      rewardNumber = [];
      json['reward_number'].forEach((v) {
        rewardNumber?.add(RewardNumber.fromJson(v));
      });
    }
    if (json['reward_money'] != null) {
      rewardMoney = [];
      json['reward_money'].forEach((v) {
        rewardMoney?.add(RewardMoney.fromJson(v));
      });
    }
  }
  int? rewardNormal;
  int? bigwinNumber;
  List<RewardNumber>? rewardNumber;
  List<RewardMoney>? rewardMoney;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reward_normal'] = rewardNormal;
    map['bigwin_number'] = bigwinNumber;
    if (rewardNumber != null) {
      map['reward_number'] = rewardNumber?.map((v) => v.toJson()).toList();
    }
    if (rewardMoney != null) {
      map['reward_money'] = rewardMoney?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class CardsWinnerGame {
  CardsWinnerGame({
      this.rewardNormal, 
      this.bigwinNumber, 
      this.rewardNumber, 
      this.rewardMoney,});

  CardsWinnerGame.fromJson(dynamic json) {
    rewardNormal = json['reward_normal'];
    bigwinNumber = json['bigwin_number'];
    if (json['reward_number'] != null) {
      rewardNumber = [];
      json['reward_number'].forEach((v) {
        rewardNumber?.add(RewardNumber.fromJson(v));
      });
    }
    if (json['reward_money'] != null) {
      rewardMoney = [];
      json['reward_money'].forEach((v) {
        rewardMoney?.add(RewardMoney.fromJson(v));
      });
    }
  }
  int? rewardNormal;
  int? bigwinNumber;
  List<RewardNumber>? rewardNumber;
  List<RewardMoney>? rewardMoney;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reward_normal'] = rewardNormal;
    map['bigwin_number'] = bigwinNumber;
    if (rewardNumber != null) {
      map['reward_number'] = rewardNumber?.map((v) => v.toJson()).toList();
    }
    if (rewardMoney != null) {
      map['reward_money'] = rewardMoney?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}