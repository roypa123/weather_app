import 'dart:developer';

import 'package:either_dart/either.dart';
import '../../../core/configs/constants/app_constants.dart';
import '../../../core/data/remote/network_base_services.dart';
import '../model/weather_data_model.dart';

abstract class MainRepo {
  Future<Either<ResponseError, WeatherDataModel>> getWeatherData(
      {required String latitude, required String longitude});
}

class MainRepoImplements extends MainRepo {
  MainRepoImplements({required NetWorkBaseServices networkBaseServices})
      : _networkBaseServices = networkBaseServices;

  final NetWorkBaseServices _networkBaseServices;

  @override
  Future<Either<ResponseError, WeatherDataModel>> getWeatherData(
      {required String latitude, required String longitude}) {
    log("demo");
    String endPoint =
        '${AppConstants.getWeatherData}?lat=$latitude&lon=$longitude&appid=${AppConstants.appid}';

    return _networkBaseServices
        .safe(_networkBaseServices.getRequest(
          endPoint: endPoint,
        ))
        .thenRight(_networkBaseServices.checkHttpStatus)
        .thenRight(_networkBaseServices.parseJson)
        .mapRight((right) => WeatherDataModel.fromJson(right));
  }
}
