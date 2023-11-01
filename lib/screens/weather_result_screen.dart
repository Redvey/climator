import 'dart:io';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/backround_decoration.dart';
import '../components/border_icon.dart';
import '../components/custom_button.dart';
import '../components/weather_small_container.dart';
import '../config/config.dart';
import '../config/config_keys.dart';
import '../services/weather.dart';
import '../utilities/constants.dart';
import '../utilities/degree_to_direction.dart';
import 'search_screen.dart';

class WeatherResult extends StatefulWidget {

  const WeatherResult({super.key, this.weatherData});
  final Map<dynamic, dynamic>? weatherData;

  @override
  _WeatherResultState createState() => _WeatherResultState();
}

class _WeatherResultState extends State<WeatherResult> {
  WeatherModel weatherModel = WeatherModel();
  late String imageName;
  late String kCustomButtonString;
  late IconData locationOn;

  // final iconVal = 0xe3ab;
  // final familyValue = 'MaterialIcons';
  late int temperature;
  late String cityName;
  late String weatherMain;
  late int humidityValue;
  late double windSpeed;
  late int cond;
  late String windDirection;

  final Config config = Config.manager;

  @override
  void initState() {
    kCustomButtonString = 'Made with ☃ By 🌀 Climator Team 🌀';
    settingNullValues();
    locationOn = const IconData(0xe3ab, fontFamily: 'MaterialIcons');
    updateLocationDetails(widget.weatherData);
    super.initState();
  }

  void settingNullValues() {
    temperature = 0;
    cityName = 'Lost in Space';
    weatherMain = 'Restart or \n See the Stars 🌟🌟';
    // weatherMain = 'Restart or \n See the Stars ';
    humidityValue = 0;
    windSpeed = 1000.0;
    windDirection = 'Nowhere';
    cond = 0;
    imageName = 'rain';
  }

  Future<void> updateLocationDetails(Map<dynamic, dynamic>? weatherData) async {
    if (weatherData == null) {
      settingNullValues();
    } else {
      cond = weatherData['weather'][0]['id'] as int;
      imageName = weatherModel.getWeatherIconName(cond);
      final double temp = weatherData['main']['temp'] as double;
      temperature = temp.toInt();
      cityName = weatherData['name'] as String;
      final String tempWeather = weatherData['weather'][0]['description'] as String;
      weatherMain = tempWeather.toUpperCase();
      humidityValue = weatherData['main']['humidity'] as int;
      final speedMeterPerSec = weatherData['wind']['speed']; // meter per seconds
      windSpeed = (speedMeterPerSec * 3.6).toInt().toDouble() as double;
      final windDegree = weatherData['wind']['deg'];

      if (windDegree is int) {
        windDirection = degToCompass(windDegree);
      } else {
        print('The wind degree is not of type int.');
        // Handle the situation when the type is not an integer, or consider converting it if possible.
      }
    }
  }


  Future<bool> _onWillPop() async {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit the App?'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () => exit(0),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    return false;
  }


  @override
  Widget build(BuildContext context) {
    // TODO(droidbg): PopScope will be compatible in future flutter version .
    /// return PopScope(
    /// onPopInvoked: _onWillPop,
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: ColoredBox(
          color: Colors.black,
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: kBackgroundDecoration,
              constraints: const BoxConstraints.expand(),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // SizedBox(
                    //   height: 40,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            final String? typedName = await Navigator.push(
                              context,
                              MaterialPageRoute<String>(
                                builder: (BuildContext context) {
                                  return const SearchScreen();
                                },
                              ),
                            );
                            print('$typedName');
                            if (typedName != null) {
                              final Map<dynamic, dynamic>? weatherData =
                                  await weatherModel.getCityWeatherData(
                                      typedName);

                              setState(() {
                                if (weatherData != null) {
                                  updateLocationDetails(weatherData);
                                } else {
                                  FlushbarHelper.createError(
                                    message:
                                        'City Not Found \nPlease try again',
                                    duration: const Duration(seconds: 1),
                                  );
                                  // Fluttertoast.showToast(
                                  //     msg: "City Not Found \nPlease try again",
                                  //     backgroundColor: Colors.red,
                                  //     toastLength: Toast.LENGTH_LONG,
                                  //     gravity: ToastGravity.CENTER,
                                  //     timeInSecForIosWeb: 1);
                                }
                              });
                            }
                          },
                          child: const Icon(
                            Icons.search,
                            size: 35,
                          ),
                        ),
                        BorderWithIcon(
                          colour: Colors.blue,
                          widget: Row(
                            children: <Widget>[
                              Icon(
                                locationOn,
                                color: Colors.blue,
                              ),
                              // BorderWithIcon(iconData: locationOn, colour: Colors.blue),
                              Container(
                                padding: const EdgeInsets.only(left: 2, top: 2),
                                child: Text(
                                  cityName,
                                  style: kCityTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final Map<dynamic, dynamic>? weatherData =
                                await WeatherModel().getWeatherDataByLatLong();
                            setState(() {
                              updateLocationDetails(weatherData);
                            });
                          },
                          child: const Icon(
                            Icons.refresh,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(
                        top: 10,
                      ),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Today's Report",
                        style: kReportTitleTextStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Image(
                      height: 180,
                      image: AssetImage('images/weather_icons/$imageName.png'),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    Text(
                      weatherMain,
                      textAlign: TextAlign.center,
                      style: kWeatherMainTextStyle,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            '$temperature',
                            style: kNumberTempTextStyle,
                          ),
                          Text(
                            '°',
                            style: kDegreeSign,
                          ),
                          Text(
                            'C',
                            style: kTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // Expanded(child: GetIconContent(icon, value, text)),
                          Expanded(
                            child: WeatherDetailsWithIcon(
                              // iconText: 'Wind~~',
                              iconText: '☀☁',
                              detailText: '${windSpeed}km/hr',
                              labelText: 'Wind Speed',
                            ),
                          ),
                          Expanded(
                            child: WeatherDetailsWithIcon(
                              // iconText: 'Weather',
                              iconText: '🌧️',
                              detailText: '$humidityValue%',
                              labelText: 'Humidity',
                            ),
                          ),
                          Expanded(
                            child: WeatherDetailsWithIcon(
                              // iconText: 'Compass',
                              iconText: '🧭',
                              detailText: windDirection,
                              labelText: 'Wind Direction',
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      text: kCustomButtonString,
                      kBottomMargin: 10,
                      borderColor: Colors.blue[500]!,
                      textColor: Colors.blue,
                      onPressed: () async {
                        try {
                          final String url = config.get(ConfigKeys.teamId);
                          await launchUrl(Uri.parse(url));
                        } catch (e) {
                          print('Error in launching url $e');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
