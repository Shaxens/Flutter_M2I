import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getWeatherData(
      double latitude, double longitude) async {
    try {
      final apiKey = dotenv.env['WEATHER_API_KEY'];

      final response = await _dio.get(
          "https://api.openweathermap.org/data/2.5/weather",
          queryParameters: {
            'lat': latitude,
            'lon': longitude,
            'appid': apiKey,
            'units': 'metric'
          });

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
            'Erreur lors de la récupération des données météorologiques');
      }
    } catch (e) {
      throw ('Erreur : $e');
    }
  }
}
