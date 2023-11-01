import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';

import '../services/weather.dart';
import '../utilities/constants.dart';
import 'weather_result_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentCoordinates();
  }

  Future<void> getCurrentCoordinates() async {
    FlushbarHelper.createInformation(
      message: 'Fetching Weather Data....',
      duration: const Duration(seconds: 1),
    );

    final Map<dynamic, dynamic>? weatherData = await WeatherModel().getCityWeatherData('London');

    FlushbarHelper.createSuccess(
      message: 'Weather Data Received',
      duration: const Duration(seconds: 1),
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<WeatherResult>(
        builder: (BuildContext context) {
          return WeatherResult(
            weatherData: weatherData,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: spinkit,
      ),
    );
  }
}
