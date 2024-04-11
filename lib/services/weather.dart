import 'location.dart';
import 'package:clima/services/networking.dart';

const apiKey = "*";
const openWeatherMapURL = 'http://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location l = Location();
    await l.getCurrentLocation();

    NetworkHelper network = NetworkHelper(
        '$openWeatherMapURL?lat=${l.latitude}&lon=${l.longitude}&appid=$apiKey&units=metric');
    var weatherData = await network.getWeatherData();
    return weatherData;
  }

  Future<dynamic> getCityWeather(String query) async {
    NetworkHelper network =
        NetworkHelper('$openWeatherMapURL?q=$query&appid=$apiKey&units=metric');
    var weatherData = await network.getWeatherData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
