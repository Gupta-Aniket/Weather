import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

class Location {
// making a connection with the api right now.

  double latitude = 0.0, longitude = 0.0;

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
