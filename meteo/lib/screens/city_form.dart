import 'package:flutter/material.dart';
import 'package:meteo/services/city_api_service.dart';
import 'package:meteo/services/weather_api_service.dart';
import 'package:meteo/widgets/weather_display.dart';

class CityFormPage extends StatelessWidget {
  const CityFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recherche de ville'),
      ),
      body: const CityForm(),
    );
  }
}

class CityForm extends StatefulWidget {
  const CityForm({super.key});

  @override
  State<CityForm> createState() => _CityFormState();
}

class _CityFormState extends State<CityForm> {
  final CityService _cityService = CityService();
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _cityController = TextEditingController();
  String _cityName = '';
  bool _loading = false;
  Future<Map<String, dynamic>>? _weatherFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recherche de ville'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Nom de la ville',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _cityName = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed:
                  _cityName.isEmpty || _loading ? null : _onSearchPressed,
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text('Obtenir la météo'),
            ),
            const SizedBox(height: 16.0),
            if (_weatherFuture != null)
              FutureBuilder<Map<String, dynamic>>(
                future: _weatherFuture,
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  if (snapshot.hasError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Erreur: ${snapshot.error}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    });
                    return Container();
                  } else if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return WeatherDisplay(
                      cityName: data['cityName'] ?? '',
                      country: data['country'] ?? '',
                      temperature: data['temperature'] ?? 0.0,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  void _onSearchPressed() {
    setState(() {
      _loading = true;
      _weatherFuture = _fetchWeather();
    });
  }

  Future<Map<String, dynamic>> _fetchWeather() async {
    setState(() {
      _loading = true;
    });

    try {
      final cityCoordinates = await _cityService.getCityCoordinates(_cityName);
      final weatherData = await _weatherService.getWeatherData(
          cityCoordinates['latitude'], cityCoordinates['longitude']);

      setState(() {
        _loading = false;
      });

      return {
        'cityName': cityCoordinates['name'],
        'country': cityCoordinates['country'],
        'temperature': weatherData['main']['temp'],
      };
    } catch (e) {
      setState(() {
        _loading = false;
      });

      throw Exception('Erreur lors de la récupération des données: $e');
    }
  }
}
