import 'package:codezend_machinetest/view/weather_screen.dart';
import 'package:flutter/material.dart';

class InputScreen extends StatelessWidget {
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("asset/images/clear.jpg"),
                fit: BoxFit.cover)),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                hintText: 'Enter Location',
                filled: true,
                fillColor: Colors.white.withOpacity(.7),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeatherScreen(
                      location: locationController.text,
                    ),
                  ),
                );
              },
              child: Text(
                'Get Weather',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
