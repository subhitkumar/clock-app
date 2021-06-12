import 'package:clock_app/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClockAnimate extends StatefulWidget {
  @override
  _ClockAnimateState createState() => _ClockAnimateState();
}

class _ClockAnimateState extends State<ClockAnimate> {
  Tween<double> tween = Tween(begin: 0.0, end: 1.0);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: TweenAnimationBuilder(
          tween: tween,
          duration: Duration(seconds: 3),
          builder: (BuildContext context, double opacity, Widget child) {
            return Opacity(
              opacity: opacity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/1.png',
                    height: 200,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Clockwheel",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w300),
                    ),
                  )
                ],
              ),
            );
          },
          onEnd: () {
            Get.off(() => HomeScreen());
          },
        ),
      ),
    );
  }
}
