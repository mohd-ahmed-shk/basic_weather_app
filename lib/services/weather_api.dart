import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/weather_response.dart';

class WeatherAPI {
  Future<Weather>? getCurrentWeather(String? location) async {
    var endpoint = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=eb42031611601a1401c1e7423f7ce112&units=metric");
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    return Weather.fromJson(body);

  }
}