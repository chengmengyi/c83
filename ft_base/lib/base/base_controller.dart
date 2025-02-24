import 'package:ft_base/util/event/event_result.dart';
import 'package:get/get.dart';

class BaseController extends GetxController{
  EventResult? _eventResult;

  @override
  void onInit() {
    super.onInit();
    _eventResult=initEventResult();
  }

  EventResult? initEventResult()=>null;


  @override
  void onClose() {
    super.onClose();
    _eventResult?.cancel();
  }
}