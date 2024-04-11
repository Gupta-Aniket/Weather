import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'loading_screen.dart';
import 'package:clima/screens/loading_screen.dart';
import 'package:clima/services/weather.dart';
import 'dart:convert';
import 'city_search_screen.dart';

class LocationScreen extends StatefulWidget {
  var locationWeather;
  LocationScreen({this.locationWeather});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature = 0;
  String weatherEmoji = "";
  String cityName = "";
  String weatherMessage = "";
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
    //passing the data to the state of a class, widget is a different object of a class
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      // if(weatherData == null) {}
      // i was thinking of doing this but i am not rn as this is handeld by default idk how but it is, i am thinking it is the api
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      var condition = weatherData['weather'][0]['id'];
      weatherEmoji = weather.getWeatherIcon(condition);

      cityName = weatherData['name'];

      weatherMessage = weather.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedCityName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Forecast();
                          },
                        ),
                      );

                      if (typedCityName != " ") {
                        var cityWeatherData =
                            await weather.getCityWeather(typedCityName);
                        updateUI(cityWeatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temperature.toString()}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherEmoji,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in \n $cityName",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
              SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

// double tempreature = decode["main"]["temp"];
//
// String cityName = decode["name"];
