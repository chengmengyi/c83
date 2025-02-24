import 'package:ft_a/hep/user_info_hep.dart';
import 'package:ft_base/base/base_controller.dart';
import 'package:ft_base/routers/routers_utils.dart';
import 'package:ft_base/util/ad/ad_hep.dart';

class BigWinController extends BaseController{

  clickDou(int reward,Function() dismiss){
    AdHep.instance.showAd(
      closeAd: (){
        UserInfoHep.instance.updateUserCoins(reward*2);
        RouterUtils.back();
        dismiss.call();
      }
    );

  }

  clickSingle(int reward,Function() dismiss){
    UserInfoHep.instance.updateUserCoins(reward);
    RouterUtils.back();
    dismiss.call();
  }
}