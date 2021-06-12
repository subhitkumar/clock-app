class WeatherData {
  DateTime date;
  String name;
  double temprature;
  String main;
  String description;
  String icon;

  WeatherData(
      {this.date,
      this.name,
      this.temprature,
      this.main,
      this.icon,
      this.description});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      date: new DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000,
          isUtc: false),
      name: json['name'],
      temprature: json['main']['temp'],
      main: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
      description: json['weather'][0]['description'],
    );
  }
}
