import 'package:flutter/material.dart';
import 'package:land_slade_guardian/api_services/api_service.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController locationController = TextEditingController();

  String? temperature;

  String? humidity;

  String? wind;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Home icon at the top
              Align(
                alignment: Alignment.topLeft,
                child: Icon(Icons.home_outlined, size: 28, color: Colors.black),
              ),

              const SizedBox(height: 32),

              // Search bar
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFE5DED3),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: locationController,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      Icon(Icons.search, color: Colors.black),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Get weather button
              GestureDetector(
                onTap: () async {
                  if (locationController.text.isNotEmpty) {
                    WeatherService weatherService = WeatherService();
                    var weatherData = await weatherService.getWeather(
                      locationController.text,
                    );
                    print(weatherData);
                    if (weatherData != null) {
                      print("🌡 Temperature: ${weatherData['temperature']}°C");
                      print("💧 Humidity: ${weatherData['humidity']}%");
                      print("💨 Wind Speed: ${weatherData['windSpeed']} m/s");
                    } else {
                      print("Failed to fetch weather data.");
                    }
                  }
                },

                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFCBBEA0),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      'get weather',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Weather information ̰
              if (temperature != null || humidity != null || wind != null)
                Column(
                  children: [
                    Text(
                      'SREEKRISHNAPURAM',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Overcast clouds',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Temperature : 26.52 °C',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Humidity: 84%',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Wind:2.11m/s',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
