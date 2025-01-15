
import 'package:flutter/material.dart';
import 'package:weather_app/init_weather_app.dart';
import 'package:weather_app/weather_app.dart';


Future<void> main() async {
  await initWeatherApp();
  runApp(const WeatherApp());
}
