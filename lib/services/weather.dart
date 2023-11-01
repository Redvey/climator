import 'location.dart';
import 'network_dio.dart';

class WeatherModel {
  Future<Map<String, dynamic>?> getWeatherDataByLatLong() async {
    Map<String, dynamic>? weatherData;
    final Locations locations = Locations();
    await locations.getCoordinates();

    weatherData = await NetworksDio()
        .getDataByLatLong(locations.longitude, locations.latitude);

    return weatherData;
  }

  Future<Map<String, dynamic>?> getCityWeatherData(String city) async {
    Map<String, dynamic>? weatherData;
    weatherData = await NetworksDio().getDataByCity(city);
    return weatherData;
  }

  String getWeatherIconName(int condition) {
    if (condition < 300) {
      return 'moon_lightning';
    } else if (condition < 400) {
      return 'cloud_rain';
    } else if (condition < 600) {
      return 'rain';
    } else if (condition < 700) {
      return 'snow';
    } else if (condition < 800) {
      return 'breeze';
    } else if (condition == 800) {
      return 'clear_sun';
    } else if (condition <= 804) {
      return 'clear_cloud';
    } else {
      return 'night_cloud';
    }
  }
}
