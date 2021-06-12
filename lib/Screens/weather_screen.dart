import 'dart:convert';
import 'package:clock_app/Models/weather_model.dart';
import 'package:clock_app/Screens/searched_weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String apikey = '88ab51cd7bbae53c9ed6a9564e563c8a';
  bool isLoading;
  WeatherData weatherData;
  getWeather() async {
    setState(() {
      isLoading = true;
    });
    Position posotion;
    try {
      posotion = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      print(posotion);
    } catch (e) {
      print(e);
    }
    if (posotion != null) {
      final lat = posotion.latitude.toString();
      final lon = posotion.longitude.toString();
      final weatherResponse = await http.get(
          'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apikey');

      if (weatherResponse.statusCode == 200) {
        return setState(() {
          weatherData = WeatherData.fromJson(jsonDecode(weatherResponse.body));
          isLoading = false;
        });
      }
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
    String query;
    return isLoading
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
        : SingleChildScrollView(
            child: SafeArea(
              child: Container(
                alignment: Alignment.center,
                child: Column(
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
                            Icons.search,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text("Search"),
                                    content: TextField(
                                      onChanged: (newText) {
                                        query = newText;
                                        print(newText);
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Enter a valid location ",
                                        contentPadding:
                                            EdgeInsets.only(bottom: 5),
                                        isDense: true,
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            Color(0xff0097a7),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (_) {
                                            return Material(
                                              child: SearchedWeatherScreen(
                                                query: query,
                                              ),
                                            );
                                          }));
                                        },
                                        child: Text("Go"),
                                      ),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              Color(0xff0097a7),
                                            ),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("Cancle"))
                                    ],
                                  );
                                });
                          }),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
