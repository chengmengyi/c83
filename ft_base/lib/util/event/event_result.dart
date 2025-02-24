import 'dart:async';
import 'package:ft_base/util/event/event_data.dart';

class EventResult{
  late StreamSubscription<EventData>? _ss;

  EventResult({required Function(EventData) call}){
    _ss=eventBus.on<EventData>().listen((event) {
      call.call(event);
    });
  }

  cancel(){
    _ss?.cancel();
  }
}