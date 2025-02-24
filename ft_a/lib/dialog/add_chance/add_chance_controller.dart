import 'package:ft_a/hep/game_config_hep.dart';
import 'package:ft_a/hep/user_info_hep.dart';
import 'package:ft_base/base/base_controller.dart';
import 'package:ft_base/routers/routers_utils.dart';
import 'package:ft_base/util/ad/ad_hep.dart';

class AddChanceController extends BaseController{

  clickVideo(WinnerType winnerType){
    AdHep.instance.showAd(
      closeAd: (){
        RouterUtils.back();
        _addPlayNum(winnerType, true);
      },
    );
  }

  clickCoins(WinnerType winnerType){
    RouterUtils.back();
    _addPlayNum(winnerType, false);
  }

  _addPlayNum(WinnerType winnerType,bool fromVideo){
    UserInfoHep.instance.updateCanPlayNum(1,winnerType,fromVideo: fromVideo);
  }
}