import 'package:clock_app/Models/timer_data.dart';
import 'package:clock_app/Screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimerData(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clockwheel',
        color: Color(0xff0097a7),
        home: SplashScreen(),
      ),
    );
  }
}
