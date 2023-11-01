import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

const double borderRadius = 20.0;

const double kDetailsContainerHeight = 75.0;
const double kBottomContainerHeight = 50.0;
const Color kSearchBarColor = Color(0xFF151638);

TextStyle kUpperTextStyle = GoogleFonts.lato(fontSize: 20.0);
TextStyle kCityTextStyle = GoogleFonts.lato(
  color: Colors.white,
  fontWeight: FontWeight.bold,
);
TextStyle kReportTitleTextStyle = GoogleFonts.raleway(
  fontSize: 30,
  fontWeight: FontWeight.w800,
);
TextStyle kWeatherMainTextStyle = GoogleFonts.raleway(
  fontSize: 25,
  fontWeight: FontWeight.w600,
);
TextStyle kNumberTempTextStyle = GoogleFonts.pacifico(
  fontSize: 50,
  fontWeight: FontWeight.w600,
);
TextStyle kTextStyle = GoogleFonts.pacifico(
  fontSize: 30,
  fontWeight: FontWeight.w600,
);
TextStyle kCityNameTextStyle = GoogleFonts.pacifico(
  fontSize: 30,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);
TextStyle kDegreeSign = GoogleFonts.raleway(
  color: Colors.blue,
  fontSize: 50.0,
  fontWeight: FontWeight.w900,
);
TextStyle kSmallNumber = GoogleFonts.pacifico(
  fontSize: 15,
  fontWeight: FontWeight.w400,
);
TextStyle kSmallTextLabelTextStyle = GoogleFonts.lato(
  fontSize: 14,
// fontWeight: FontWeight.w400,
);

//............................................
const SpinKitSpinningLines spinkit = SpinKitSpinningLines(
  color: Colors.white,
  lineWidth: 6.0,
);

const TextStyle kLargeTextStyle = TextStyle(
  fontSize: 35.0,
  fontWeight: FontWeight.bold,
);

const TextStyle kMediumTextStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.white60,
);
