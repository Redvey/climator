// ignore: eol_at_end_of_file
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:another_flushbar/flushbar_helper.dart';

class Locations {
  late Position position;
  late double latitude;
  late double longitude;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
      forceAndroidLocationManager: true,
      timeLimit: Duration(seconds: 10),
    );
  }

  Future<void> getCoordinates() async {
    try {
      position = await _determinePosition();
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print("In locations error");
      FlushbarHelper.createError(
        title: "Error",
        message:
        "Either give proper permissions \n or Give refresh & \n Wait for the data to load",
        duration: Duration(seconds: 3),
      );
      // Fluttertoast.showToast(
      //     msg:
      //         "Error: Either give proper permissions \n or Give refresh & \n Wait for the data to load",
      //     backgroundColor: Colors.red,
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 3);
      print(e.toString());
    }
  }
}