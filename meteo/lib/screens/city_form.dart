import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:meteo/datas/city_data.dart';
import 'package:meteo/datas/weather_data.dart';
import 'package:meteo/services/city_api_service.dart';
import 'package:meteo/services/weather_api_service.dart';
import 'package:meteo/widgets/weather_display.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Future<WeatherData>? _weatherFuture;
  List<City> _selectedCities = [];

  @override
  void initState() {
    super.initState();
    _loadSelectedCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recherche de ville'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                    : const Text('Ajouter la ville'),
              ),
              const SizedBox(height: 16.0),
              if (_weatherFuture != null)
                FutureBuilder<WeatherData>(
                  future: _weatherFuture,
                  builder: (BuildContext context,
                      AsyncSnapshot<WeatherData> snapshot) {
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
                      return Flexible(
                        child: Column(
                          children: [
                            ListView.builder(
                              itemCount: _selectedCities.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final city = _selectedCities[index];
                                return ListTile(
                                  title: Text(city.name),
                                  subtitle: Text(city.country),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => _removeCity(city),
                                  ),
                                  onTap: () => _showWeather(city),
                                );
                              },
                            ),
                            WeatherDisplay(
                              cityName: data.cityCoordinates['name'] ?? '',
                              country: data.cityCoordinates['country'] ?? '',
                              temperature:
                                  data.weatherData['main']['temp'] ?? 0.0,
                            ),
                            SizedBox(
                              height: 600,
                              width: 400,
                              child: FlutterMap(
                                options: MapOptions(
                                  initialCenter: LatLng(
                                      data.weatherData['coord']['lat'],
                                      data.weatherData['coord']['lon']),
                                  initialZoom: 12,
                                ),
                                children: [
                                  TileLayer(
                                    urlTemplate:
                                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                    userAgentPackageName: 'com.example.fr',
                                  ),
                                  MarkerLayer(
                                    markers: [
                                      Marker(
                                        point: LatLng(
                                            data.weatherData['coord']['lat'],
                                            data.weatherData['coord']['lon']),
                                        child: const Icon(
                                          Icons.location_pin,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
            ],
          ),
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

  Future<WeatherData> _fetchWeather() async {
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

      _addCity(City(
          name: cityCoordinates['name'],
          country: cityCoordinates['country'],
          latitude: weatherData['coord']['lat'],
          longitude: weatherData['coord']['lon']));

      return WeatherData(
          cityCoordinates: cityCoordinates, weatherData: weatherData);
    } catch (e) {
      setState(() {
        _loading = false;
      });

      throw Exception('Erreur lors de la récupération des données: $e');
    }
  }

  void _showWeather(City city) async {
    setState(() {
      _loading = true;
    });

    try {
      final weatherData =
          await _weatherService.getWeatherData(city.latitude, city.longitude);

      setState(() {
        _loading = false;
      });

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Météo pour ${city.name}'),
            content: WeatherDisplay(
              cityName: city.name,
              country: city.country,
              temperature: weatherData['main']['temp'] ?? 0.0,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Fermer'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      setState(() {
        _loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Erreur : $e',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }
  }

  void _removeCity(City city) {
    setState(() {
      _selectedCities.remove(city);
      _saveSelectedCities();
    });
  }

  void _addCity(City city) {
    setState(() {
      _selectedCities.add(city);
      _saveSelectedCities();
    });
  }

  Future<void> _loadSelectedCities() async {
    final prefs = await SharedPreferences.getInstance();
    final citiesData = prefs.getStringList('selectedCities') ?? [];
    setState(() {
      _selectedCities = citiesData.map((cityData) {
        final cityMap = jsonDecode(cityData);
        return City.fromMap(cityMap);
      }).toList();
    });
  }

  Future<void> _saveSelectedCities() async {
    final prefs = await SharedPreferences.getInstance();
    final citiesData = _selectedCities.map((city) {
      return jsonEncode(city.toMap());
    }).toList();
    await prefs.setStringList('selectedCities', citiesData);
  }
}
