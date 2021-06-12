import 'package:clock_app/widgets/time_widget.dart';
import 'package:flutter/material.dart';

class TimeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              "Clock",
              style: TextStyle(fontSize: 20, color: Color(0xff00838f)),
            ),
          ),
          SizedBox(
            height: 150,
          ),
          Container(alignment: Alignment.center, child: CurrentTime()),
          Container(child: CurrentDate())
        ],
      ),
    );
  }
}
