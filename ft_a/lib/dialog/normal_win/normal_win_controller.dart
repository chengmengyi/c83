import 'package:ft_a/hep/user_info_hep.dart';
import 'package:ft_base/base/base_controller.dart';
import 'package:ft_base/routers/routers_utils.dart';

class NormalWinController extends BaseController{

  clickGet(int reward,Function() dismiss){
    UserInfoHep.instance.updateUserCoins(reward);
    RouterUtils.back();
    dismiss.call();
  }
}