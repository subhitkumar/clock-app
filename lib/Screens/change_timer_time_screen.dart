import 'package:clock_app/Models/timer_data.dart';
import 'package:clock_app/Screens/pushed_timer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ChnageTimerTimeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int timerTime;
    return Container(
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Create a timer",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                autofocus: true,
                cursorColor: Colors.grey,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  hintText: "0 seconds",
                ),
                onChanged: (newText) {
                  timerTime = int.parse(newText);
                },
              ),
              TextButton(
                onPressed: () {
                  Provider.of<TimerData>(context, listen: false)
                      .updateTimerTime(timerTime);
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Material(
                                child: PushedTimerScreen(),
                              )));
                },
                child: Text(
                  "Done",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff0097a7))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
