import 'package:flutter/cupertino.dart';

class TimerData extends ChangeNotifier {
  int duration;
  TimerData({this.duration = 10});
  void updateTimerTime(int _durationText) {
    duration = _durationText;
    notifyListeners();
  }

  int get timerDuration {
    return duration;
  }
}
