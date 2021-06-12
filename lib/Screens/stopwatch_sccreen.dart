import 'package:clock_app/lap_icons.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopwatchScreen extends StatefulWidget {
  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final _isHours = true;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    isLapHours: true,
  );

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Stopwatch",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff00838f),
                ),
              ),
            ),
            SizedBox(
              height: 150,
            ),

            /// Display stop watch time
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: _stopWatchTimer.rawTime.value,
                builder: (context, snap) {
                  final value = snap.data;
                  final displayTime =
                      StopWatchTimer.getDisplayTime(value, hours: _isHours);
                  return Column(
                    children: <Widget>[
                      Text(
                        displayTime,
                        style: const TextStyle(
                            fontSize: 50, fontWeight: FontWeight.w300),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),

            /// Lap time.
            Container(
              height: 120,
              margin: const EdgeInsets.all(8),
              child: StreamBuilder<List<StopWatchRecord>>(
                stream: _stopWatchTimer.records,
                initialData: _stopWatchTimer.records.value,
                builder: (context, snap) {
                  final value = snap.data;
                  if (value.isEmpty) {
                    return Container();
                  }
                  Future.delayed(const Duration(milliseconds: 100), () {
                    _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut);
                  });

                  return ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final data = value[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              '${data.displayTime}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w300),
                            ),
                          ),
                          const Divider(
                            height: 1,
                          )
                        ],
                      );
                    },
                    itemCount: value.length,
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),

            /// Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xff0097a7),
                  child: IconButton(
                    icon: Icon(
                      Lap.play,
                      color: Colors.white,
                      size: 15,
                    ),
                    onPressed: () async {
                      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
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
                      Icons.stop,
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
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
                      Lap.arrows_cw,
                      size: 15,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
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
                      Lap.stopwatch,
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      _stopWatchTimer.onExecute.add(StopWatchExecute.lap);
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
