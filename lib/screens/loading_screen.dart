import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:clima/services/location.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
        print("init called");
        getLocationData();
      }

  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();
    // var weatherData = await weatherModel.getLocationWeather;
    // simply calling the function like this wont work:
    // because i dont know how to call a function, the function call always uses parenthesis.
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    print("build called");
    getLocationData();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Icon(
              Icons.location_on_sharp,
              size: 100,
            ),
            SpinKitThreeBounce(
              color: Colors.white70,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
