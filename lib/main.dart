import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Info App Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Weather Info App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _cityNameController = TextEditingController();
  String _cityInputName = "";
  String _cityName = "";
  String _cityTemperature = "";
  String _cityWeatherCondition = "";
  final Map<String, Map<String, String>> cityWeatherMap = HashMap();
  final Random random = Random();
  final List<String> cityWeatherConditionList = ["Sunny", "Cloudy", "Rainy"];

  final Map<String, String> atlantaWeatherMap = {
  "cityName": "Atlanta",
  };

  final Map<String, String> seattleWeatherMap = {
    "cityName": "Seattle",
  };

  final Map<String, String> newYorkWeatherMap = {
    "cityName": "New York City",
  };

  final Map<String, String> miamiWeatherMap = {
    "cityName": "Miami",
  };

  @override
  void initState() {
    super.initState();
    cityWeatherMap["atlanta"] = atlantaWeatherMap;
    cityWeatherMap["seattle"] = seattleWeatherMap;
    cityWeatherMap["newyorkcity"] = newYorkWeatherMap;
    cityWeatherMap["miami"] = miamiWeatherMap;
  }

  // Fetch weather data for a specific city
  void _fetchWeatherData() {
    setState(() {
      _cityInputName = _cityNameController.text;
      _fetchCityName(_cityInputName);
      _fetchCityTemperature(_cityInputName);
      _fetchCityWeatherCondition(_cityInputName);
    });

    // Clear the text field controller and the city input name
    _cityNameController.clear();
    _cityInputName = "";
  }

  // Fetch the city name for inputted city
  void _fetchCityName(final String cityName) {
    setState(() {
      // If the inputted city is not found in the HashMap return Not Found
      _cityName = cityWeatherMap[cityName.toLowerCase()
          .replaceAll(' ', '')]?["cityName"] ?? "Not Found";
    });
  }

  // Fetch the temperature for a specific city
  void _fetchCityTemperature(final String cityName) {
    setState(() {
      if(!cityWeatherMap.containsKey(cityName.toLowerCase().replaceAll(' ', ''))) {
        _cityTemperature = "Not Found";
        return;
      }

      final int temperatureRandomInt = 15 + random.nextInt(16);
      _cityTemperature = "$temperatureRandomInt°C";;
    });
  }

  // Fetch the weather condition for a specific city
  void _fetchCityWeatherCondition(final String cityName) {
    setState(() {
      if(!cityWeatherMap.containsKey(cityName.toLowerCase().replaceAll(' ', ''))) {
        _cityWeatherCondition = "Not Found";
        return;
      }

      final int weatherConditionRandomInt = random.nextInt(3);
      _cityWeatherCondition = cityWeatherConditionList[weatherConditionRandomInt];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Weather Info App',
            ),
            Text(
              'Enter your city here for weather info!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _cityNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter City Name:',
                ),
              ),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: _fetchWeatherData,
              child: Text('Fetch Weather'),
            ),
            SizedBox(height: 8.0),
            Text(
              'City Name: ' + _cityName
            ),
            SizedBox(height: 8.0),
            Text(
              'Temperature: ' + _cityTemperature
            ),
            SizedBox(height: 8.0),
            Text(
                'Weather Condition: ' + _cityWeatherCondition
            ),
          ],
        ),
      ),
    );
  }
}
