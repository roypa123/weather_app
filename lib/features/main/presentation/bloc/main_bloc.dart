import 'dart:developer';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/main/repo/main_repo.dart';
import '../../../../core/configs/constants/app_json.dart';
import '../../model/weather_data_model.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc({required MainRepo mainRepo})
      : _mainRepo = mainRepo,
        super(MainInitial()) {
    on<GetDataEvent>(_getDataEvent);
  }

  final MainRepo _mainRepo;
  double latitude = 0;
  double longitude = 0;
  String name = "";
  double humidity = 0;
  double windspeed = 0;
  double temperature = 0;
  String condition = "";
  WeatherDataModel? weatherDataModel;

  Future<void> _getDataEvent(
      GetDataEvent event, Emitter<MainState> emit) async {
    log("dep1");
    latitude = event.latitude;
    longitude = event.longitude;
    await _mainRepo
        .getWeatherData(
            latitude: latitude.toString(), longitude: longitude.toString())
        .fold((left) {
      log("wrong");
    }, (right) {
      log("right");
      name = right.name;
      humidity = right.main.humidity.toDouble();
      windspeed = right.wind.speed;
      temperature = right.main.temp;
      final celsius = temperature - 273.15;
      switch (right.weather.first.main) {
        case "Clouds":
          condition = AppJson.jsonCloudy;
          break;
        case "Haze":
          condition = AppJson.jsonSunny;
          break;
        case "Sunny":
          condition = AppJson.jsonSunny;
          break;
        case "Thunder":
          condition = AppJson.jsonThunder;
          break;

        default:
          condition = "";
      }

      emit(
        MainSuccess(
            name: name,
            humidity: humidity.toStringAsFixed(1),
            windSpeed: windspeed.toStringAsFixed(1),
            temperature: celsius.toStringAsFixed(1),
            condition: condition),
      );
    });
  }
}
