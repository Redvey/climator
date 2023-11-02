import 'package:dio/dio.dart';

import '../config/config.dart';
import '../config/config_keys.dart';

class NetworksDio {
  Dio dio = Dio();

  String byCity(String city) {
    return '${getBaseURL()}q=$city&appid=${getApiKey()}&units=metric';
  }

  String getBaseURL() {
    final Config config = Config.manager;
    return config.get(ConfigKeys.baseURL);
  }

  String getApiKey() {
    final Config config = Config.manager;
    return config.get(ConfigKeys.apiKey);
  }

  String byLatLong({required double latitude, required double longitude}) {
    return '${getBaseURL()}lat=$latitude&lon=$longitude&appid=${getApiKey()}&units=metric';
  }

  Future<Map<String, dynamic>?> getDataByCity(String cityName) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.get<Map<String, dynamic>>(byCity(cityName));
      return decodeResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw Exception('Connection timed out. Please try again later.');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception('Server error. Please try again later.');
      } else {
        throw Exception('Unknown error occurred. Please try again later.');
      }
    } catch (e) {
      throw Exception('Unknown error occurred. Please try again later.');
    }
  }

  Future<Map<String, dynamic>?> getDataByLatLong(double longitude, double latitude) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.get<Map<String, dynamic>>(byLatLong(latitude: latitude, longitude: longitude));
      return decodeResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw Exception('Connection timed out. Please try again later.');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception('Server error. Please try again later.');
      } else {
        throw Exception('Unknown error occurred. Please try again later.');
      }
    } catch (e) {
      throw Exception('Unknown error occurred. Please try again later.');
    }
  }

  Map<String, dynamic>? decodeResponse(Response<dynamic> response) {
    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    } else {
      throw Exception('Server error. Please try again later.');
    }
  }

}
