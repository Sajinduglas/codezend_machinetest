import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherService {
  Future<Map<String, dynamic>> getWeather(String location) async {
    const apiKey = 'ccd1942e01b7dcdf1b54e6890895e540';
    final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey&units=metric',
    ));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
