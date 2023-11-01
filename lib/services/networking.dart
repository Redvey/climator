import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/config.dart';
import '../config/config_keys.dart';

class Networks {

  Networks() {
    _config = Config.manager;
  }
  late Config _config;

  String getBaseURL() {
    return _config.get(ConfigKeys.baseURL);
  }

  String getApiKey() {
    return _config.get(ConfigKeys.apiKey);
  }

  String byCity(String city) {
    return '${getBaseURL()}q=$city&appid=${getApiKey()}&units=metric';
  }

  String byLatLong({required double latitude, required double longitude}) {
    return '${getBaseURL()}?lat=$latitude&lon=$longitude&appid=${getApiKey()}&units=metric';
  }

  Future<Map<dynamic, dynamic>?> getDataByCity(String cityName) async {
    try {
      final String url = byCity(cityName);
      final http.Response response = await http.get(Uri.parse(url));
      return decodeResponse(response);
    } catch (e) {
      throw Exception('An error occurred while fetching data.');
    }
  }

  Future<Map<dynamic, dynamic>?> getDataByLatLong(double longitude, double latitude) async {
    try {
      final http.Response response = await http.get(Uri.parse(byLatLong(latitude: latitude, longitude: longitude)));
      return decodeResponse(response);
    } catch (e) {
      throw Exception('An error occurred while fetching data.');
    }
  }

  Map<dynamic, dynamic>? decodeResponse(http.Response response) {
    dynamic resultData;
    if (response.statusCode == 200) {
      resultData = jsonDecode(response.body);
      // Optionally handle or log the response data
    } else {
      throw Exception('Server error occurred.');
    }
    return resultData as Map<dynamic, dynamic>;
  }
}
