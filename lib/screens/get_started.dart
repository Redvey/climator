import 'package:flutter/material.dart';
import '../components/backround_decoration.dart';
import '../components/custom_button.dart';
import '../utilities/constants.dart';
import 'loading_screen.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: kBackgroundDecoration,
        constraints: const BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const SizedBox(
              height: 100.0,
            ),
            const Expanded(
              flex: 2,
              child: Image(
                image: AssetImage('images/weather_icons/sun.png'),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            const Expanded(
              child: Text(
                'Discover the Weather in Your City',
                textAlign: TextAlign.center,
                style: kLargeTextStyle,
              ),
            ),
            const Expanded(
              child: Text(
                'Get to know your weather maps and radar precipitation forecast',
                textAlign: TextAlign.center,
                style: kMediumTextStyle,
              ),
            ),
            CustomButton(
              text: 'Get Started',
              kBottomMargin: 40,
              borderColor: Colors.blue.shade500,
              textColor: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<LoadingScreen>(
                    builder: (BuildContext context) {
                      return const LoadingScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
