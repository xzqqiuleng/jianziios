import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();
class JobRefreshEvent {
  String txt;
  int type;
  JobRefreshEvent(this.txt,this.type);
}
class LoginEvent {
  LoginEvent();
}