import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import '../service/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  final String location;

  WeatherScreen({required this.location});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weatherData;
  final WeatherService weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
    weatherData = _fetchWeatherData();
  }

  Future<Map<String, dynamic>> _fetchWeatherData() async {
    return weatherService.getWeather(widget.location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Weather for ${widget.location}',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.w400, color: Colors.black),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("asset/images/clear.jpg"),
                fit: BoxFit.cover)),
        child: FutureBuilder<Map<String, dynamic>>(
          future: weatherData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.blue,
              ));
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}',style: TextStyle(fontSize: 25),),
              );
            } else {
              return _buildWeatherUI(snapshot.data!);
            }
          },
        ),
      ),
    );
  }

  Widget _buildWeatherUI(Map<String, dynamic> data) {
    final temperature = data['main']['temp'];
    final humidity = data['main']['humidity'];
    final weatherCondition = data['weather'][0]['main'];
    final icon = _getWeatherIcon(weatherCondition);

    return Container(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 150, color: Colors.black),
          SizedBox(height: 16),
          Text(
            'Temperature: $temperature °C',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(height: 8),
          Text('Humidity: $humidity%',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(String condition) {
    switch (condition) {
      case 'Clear':
        return WeatherIcons.day_sunny;
      case 'Clouds':
        return WeatherIcons.cloudy;
      case 'Rain':
        return WeatherIcons.rain;
      default:
        return WeatherIcons.day_sunny; // Default to sunny icon
    }
  }
}
