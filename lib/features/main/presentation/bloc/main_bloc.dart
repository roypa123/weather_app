import 'dart:developer';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/features/main/repo/main_repo.dart';
import '../../../../core/configs/constants/app_json.dart';
import '../../../../core/configs/constants/string_constants.dart';
import '../../../../core/utils/helpers/common_functions.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc({required MainRepo mainRepo})
      : _mainRepo = mainRepo,
        super(MainInitial()) {
    on<GetCoordinatesEvent>(_getCoordinatesEvent);
    on<GetDataEvent>(_getDataEvent);
  }

  final MainRepo _mainRepo;

  String name = "";
  double humidity = 0;
  double windspeed = 0;
  double temperature = 0;
  String condition = "";

  Future<void> _getCoordinatesEvent(
      GetCoordinatesEvent event, Emitter<MainState> emit) async {
    bool serviceEnabled;
    LocationPermission permission;
    if (!(await isInternetAvailable())) {
      emit(const ErrorState(errorMessage: Strings.noInternet));
    }
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(const ErrorState(errorMessage: Strings.locationServicesAreDisabled));
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(const ErrorState(errorMessage: Strings.locationPermissionAreDenied));
      }
    }
    if (permission == LocationPermission.deniedForever) {
      emit(const ErrorState(
          errorMessage: Strings.locationPermanentlyDenied));
    }

    Position position = await Geolocator.getCurrentPosition();
    double latitude = position.latitude;
    double longitude = position.longitude;
    add(GetDataEvent(latitude: latitude, longitude: longitude));
  }

  Future<void> _getDataEvent(
      GetDataEvent event, Emitter<MainState> emit) async {
    log("dep1");

    await _mainRepo
        .getWeatherData(
            latitude: event.latitude.toString(),
            longitude: event.longitude.toString())
        .fold((left) {
      emit(const ErrorState(
          errorMessage: 'Location permissions are permanently denied'));
    }, (right) {
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
          condition = AppJson.jsonHaze;
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
