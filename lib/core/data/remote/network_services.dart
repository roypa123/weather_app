import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

import '../../configs/constants/app_constants.dart';
import '../../utils/helpers/common_functions.dart';
import 'network_base_services.dart';

class NetworkServices extends NetWorkBaseServices {
  static const kConnectTimeOut = Duration(milliseconds: 60000);
  static const kReceiveTimeOut = Duration(milliseconds: 60000);

  final Dio dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseURL,
      receiveDataWhenStatusError: true,
      headers: {
        "Authorization": "Bearer ${AppConstants.accessToken}",
        "Content-Type": "application/json",
      }));

  @override
  Either<ResponseError, BaseResponse> checkHttpStatus(BaseResponse response) {
    return getStatus(response);
  }

  @override
  Future<BaseResponse> getRequest({required String endPoint}) async {
    if (!(await isInternetAvailable())) {
      throw ApiExceptions.noInternet();
    }

    dio.options.headers["Authorization"] = "Bearer ${AppConstants.accessToken}";

    try {
      log("URL : > ${dio.options.baseUrl}$endPoint");
      log("Headers : > API Key :: ${dio.options.headers["Api-key"]}");
      log("Headers : > Token :: ${dio.options.headers["Authorization"]}");
      Response response =
          await dio.get(endPoint).timeout(kReceiveTimeOut, onTimeout: () {
        throw ApiExceptions.oops();
      });
      log("Response : > ${response.data}");
      return BaseResponse(statusCode: response.statusCode, data: response.data);
    } on DioException catch (error) {
      return BaseResponse(
          statusCode: error.response?.statusCode, data: error.response?.data);
    } catch (e) {
      log("Error : > $e");
      throw ApiExceptions.oops();
    }
  }

  @override
  Either<ResponseError, BaseResponse> getStatus(BaseResponse response) {
    switch (response.statusCode) {
      case 200:
        return Right(response);
      case 201:
        return Right(response);
      case 400:
        return Right(response);
      case 401:
        return Left(ResponseError(
            key: ApiErrorTypes.unAuthorized,
            message: "UnAuthorized",
            response: response.data));
      case 403:
        return Left(ResponseError(
            key: ApiErrorTypes.unAuthorized,
            message: "UnAuthorized",
            response: response.data));
      case 404:
        return Left(ResponseError(
            key: ApiErrorTypes.notFound,
            message: "Not Found",
            response: response.data));
      case 422:
        return Left(ResponseError(
            key: ApiErrorTypes.unAuthorized,
            message: "UnAuthorized",
            response: response.data));
      case 500:
        return Left(ResponseError(
            key: ApiErrorTypes.internalServerError,
            message: "Internal Server Error",
            response: response.data));
      case 503:
        return Left(ResponseError(
            key: ApiErrorTypes.serviceUnavailable,
            message: "Service Unavailable",
            response: response.data));
      default:
        return Left(ResponseError(
            key: ApiErrorTypes.unknown,
            message: "Unknown",
            response: response.data));
    }
  }

  @override
  Future<Either<ResponseError, dynamic>> parseJson(
      BaseResponse response) async {
    try {
      return Right(response.data);
    } catch (e) {
      return const Left(ResponseError(
          key: ApiErrorTypes.jsonParsing, message: "Failed on json Parsing"));
    }
  }

  @override
  Future<Either<ResponseError, BaseResponse>> safe(
      Future<BaseResponse> request) async {
    try {
      return Right(await request);
    } on ApiExceptions catch (error) {
      return Left(ResponseError(
          key: error.errorType,
          message: error.message,
          response: error.response));
    } catch (e) {
      return Left(ResponseError(
          key: ApiErrorTypes.unknown, message: "Unknown Error : $e"));
    }
  }
}
