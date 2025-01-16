import 'package:either_dart/either.dart';
import '../../../core/configs/constants/app_constants.dart';
import '../../../core/data/remote/network_base_services.dart';
import '../../../core/utils/injection_container/injection_container.dart';
import '../model/weather_data_model.dart';

abstract class MainRepo {
  Future<Either<ResponseError, WeatherDataModel>> getWeatherData(
      {required String latitude, required String longitude});
}

class MainRepoImplements extends MainRepo {
  final dio = sl<NetWorkBaseServices>();

  @override
  Future<Either<ResponseError, WeatherDataModel>> getWeatherData(
      {required String latitude, required String longitude}) {
    String endPoint =
        '${AppConstants.getWeatherData}?lat=$latitude&lon=$longitude&appid=${AppConstants.getWeatherData}';

    return dio
        .safe(dio.getRequest(
          endPoint: endPoint,
        ))
        .thenRight(dio.checkHttpStatus)
        .thenRight(dio.parseJson)
        .mapRight((right) => WeatherDataModel.fromJson(right));
  }
}
