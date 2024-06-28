import 'package:flutter/material.dart';

class WeatherDisplay extends StatelessWidget {
  final String cityName;
  final String country;
  final double temperature;

  const WeatherDisplay({
    super.key,
    required this.cityName,
    required this.country,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('Ville: $cityName, Pays: $country'),
        const SizedBox(height: 10),
        Text('Température: ${temperature.toStringAsFixed(1)}°C'),
      ],
    );
  }
}
