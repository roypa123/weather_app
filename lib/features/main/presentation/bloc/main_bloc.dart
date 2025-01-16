import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/main/repo/main_repo.dart';

import '../../../../core/utils/injection_container/injection_container.dart';
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
      emit(
        MainSuccess(
          name: right.name,
          humidity: right.main.humidity.toStringAsFixed(1),
          windSpeed: right.wind.speed.toStringAsFixed(1),
          temperature: right.main.temp.toStringAsFixed(1),
        ),
      );
    });
  }
}
