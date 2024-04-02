import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final url;

  NetworkHelper(this.url);

  Future getWeatherData() async {
    final uri = Uri.parse(url);
    // converting url to uri : string to uri

    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
