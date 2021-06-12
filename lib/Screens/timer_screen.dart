import 'package:clock_app/Screens/change_timer_time_screen.dart';
import 'package:clock_app/lap_icons.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_beep/flutter_beep.dart';

// ignore: must_be_immutable
class TimerScreen extends StatelessWidget {
  CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Timer",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.center,
              child: CircularCountDownTimer(
                duration: 10,
                initialDuration: 0,
                controller: _controller,
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                ringColor: Colors.grey[300],
                ringGradient: null,
                fillColor: Color(0xff00838f),
                backgroundColor: Color(0xff0097a7),
                strokeWidth: 20.0,
                strokeCap: StrokeCap.round,
                textStyle: TextStyle(
                    fontSize: 33.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textFormat: CountdownTextFormat.S,
                isReverse: false,
                isReverseAnimation: false,
                isTimerTextShown: true,
                autoStart: false,
                onComplete: () {
                  FlutterBeep.playSysSound(41);
                },
              ),
            ),
            Text("10s"),
            SizedBox(
              height: 50,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xff0097a7),
                  child: IconButton(
                    icon: Icon(
                      Lap.play,
                      size: 15,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _controller.start();
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  backgroundColor: Color(0xff0097a7),
                  child: IconButton(
                      icon: Icon(
                        Lap.pause,
                        size: 15,
                        color: Colors.white,
                      ),
                      onPressed: () => _controller.pause()),
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  backgroundColor: Color(0xff0097a7),
                  child: IconButton(
                    icon: Icon(
                      Lap.arrows_cw,
                      size: 15,
                      color: Colors.white,
                    ),
                    onPressed: () => _controller.resume(),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  backgroundColor: Color(0xff0097a7),
                  child: IconButton(
                      icon: Icon(
                        Lap.pencil,
                        size: 15,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => SingleChildScrollView(
                            child: Container(
                              child: ChnageTimerTimeScreen(),
                            ),
                          ),
                        );
                      }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
