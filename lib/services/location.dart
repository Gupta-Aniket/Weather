import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

class Location {
// making a connection with the api right now.

  double latitude = 0.0, longitude = 0.0;

  Future<void> getCurrentLocation() async {
    Position position = Position(
      latitude: 0.0,
      longitude: 0.0,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
      altitudeAccuracy: 0.0,
      headingAccuracy: 0.0,
    );
    try {
      LocationPermission permission;
      permission = await Geolocator.requestPermission();

      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
