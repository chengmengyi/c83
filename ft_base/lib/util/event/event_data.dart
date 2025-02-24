import 'package:event_bus/event_bus.dart';

final EventBus eventBus=EventBus();

class EventData{
  int code;
  EventData({
    required this.code,
  });

  send(){
    eventBus.fire(this);
  }
}