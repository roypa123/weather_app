import 'dart:convert';

WeatherDataModel weatherDataFromJson(String str) =>
    WeatherDataModel.fromJson(json.decode(str));

class WeatherDataModel {
  List<Weather> weather;
  Main main;
  Wind wind;
  Clouds clouds;

  Sys sys;

  String name;
  int cod;

  WeatherDataModel({
    required this.weather,
    required this.main,
    required this.wind,
    required this.clouds,
    required this.sys,
    required this.name,
    required this.cod,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) =>
      WeatherDataModel(
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        main: Main.fromJson(json["main"]),
        wind: Wind.fromJson(json["wind"]),
        clouds: Clouds.fromJson(json["clouds"]),
        sys: Sys.fromJson(json["sys"]),
        name: json["name"],
        cod: json["cod"],
      );
}

class Clouds {
  int all;

  Clouds({
    required this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
      );
}

class Main {
  double temp;
  int pressure;
  int humidity;

  Main({
    required this.temp,
    required this.pressure,
    required this.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"]?.toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
      );
}

class Sys {
  String country;

  Sys({
    required this.country,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        country: json["country"],
      );
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );
}

class Wind {
  double speed;

  Wind({
    required this.speed,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?.toDouble(),
      );
}
