import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clock_app/Models/weather_model.dart';
import 'package:flutter/material.dart';

class SearchedWeatherScreen extends StatefulWidget {
  final String query;
  SearchedWeatherScreen({this.query});

  @override
  _SearchedWeatherScreenState createState() => _SearchedWeatherScreenState();
}

class _SearchedWeatherScreenState extends State<SearchedWeatherScreen> {
  String apikey = '88ab51cd7bbae53c9ed6a9564e563c8a';
  bool isLoading;

  WeatherData weatherData;
  getWeather() async {
    setState(() {
      isLoading = true;
    });
    final weatherResponse = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?q=${widget.query}&appid=$apikey');

    if (weatherResponse.statusCode == 200) {
      return setState(() {
        weatherData = WeatherData.fromJson(jsonDecode(weatherResponse.body));
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: isLoading
              ? Center(
                  child: Transform.scale(
                    scale: 2,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xff00838f),
                      ),
                    ),
                  ),
                )
              : Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: 20,
                      ),
                      child: Text(
                        "Weather",
                        style:
                            TextStyle(fontSize: 20, color: Color(0xff00838f)),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                    ),
                    Text(
                      weatherData.name + "*",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          weatherData.description,
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(width: 10),
                        Image.network(
                          'http://openweathermap.org/img/w/${weatherData.icon}.png',
                        ),
                        SizedBox(width: 10),
                        Text(
                          (weatherData.temprature - 273.15).toStringAsFixed(2) +
                              "°C",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(width: 10),
                        Text(
                          weatherData.main,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 150,
                    ),
                    CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Color(0xff0097a7),
                      child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
