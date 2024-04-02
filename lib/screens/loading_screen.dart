import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:clima/services/location.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/networking.dart';

const apiKey = "c7d1990b47fd00b2889508bdb7be4e8c";

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // WeatherFactory wf = WeatherFactory("c7d1990b47fd00b2889508bdb7be4e8c");
  double lat = 0.0;
  double long = 0.0;
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location l = Location();
    await l.getCurrentLocation();

    NetworkHelper network = NetworkHelper(
        'http://api.openweathermap.org/data/2.5/weather?lat=$l.latitude&lon=$l.longitude&appid=$apiKey&units=metric');
    // print(lat);
    // print(long);
    var weatherData = await network.getWeatherData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    getLocationData();
    return Scaffold();
  }
}
