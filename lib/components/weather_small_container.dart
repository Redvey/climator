import 'package:flutter/material.dart';
import '../utilities/constants.dart';


class WeatherDetailsWithIcon extends StatelessWidget {

  const WeatherDetailsWithIcon({super.key, 
    required this.iconText,
    required this.detailText,
    required this.labelText,
  });
  final String iconText;
  final String detailText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kDetailsContainerHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(iconText),
          ),
          Expanded(
            child: Text(
              detailText,
              style: kSmallNumber,
            ),
          ),
          Expanded(
            child: Text(
              labelText,
              style: kSmallTextLabelTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
