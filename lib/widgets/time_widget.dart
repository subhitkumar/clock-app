import 'package:clock_app/Models/timer_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timer_builder/timer_builder.dart';

class CurrentTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TimerBuilder.periodic(Duration(minutes: 1), builder: (context) {
      return Text(
        "${DateFormat.jm().format(DateTime.now())}",
        textAlign: TextAlign.center,
        style: new TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 50,
        ),
      );
    });
  }
}

class CurrentDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TimerBuilder.periodic(Duration(hours: 1), builder: (context) {
      return Text(
        "${DateFormat('\n EEE, MMM d').format(DateTime.now())}",
        textAlign: TextAlign.center,
        style: new TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 20,
        ),
      );
    });
  }
}

class CountDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
      return Text((Provider.of<TimerData>(context).duration - 1).toString());
    });
  }
}
