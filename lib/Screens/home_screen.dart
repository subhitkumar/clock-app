import 'package:clock_app/Screens/stopwatch_sccreen.dart';
import 'package:clock_app/Screens/time_screen.dart';
import 'package:clock_app/Screens/timer_screen.dart';
import 'package:clock_app/Screens/weather_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _items = [
    TimeScreen(),
    TimerScreen(),
    StopwatchScreen(),
    WeatherScreen()
  ];
  @override
  Widget build(BuildContext context) {
    void onTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: _items[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xff0097a7),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: Colors.white,
        selectedFontSize: 0,
        onTap: onTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.access_time,
              size: 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.av_timer_outlined,
              size: 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.timer,
              size: 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.cloud,
                size: 39,
              ),
              label: '')
        ],
      ),
    );
  }
}
