import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CityService {
  final Dio _dio = Dio();

  CityService() {
    _dio.options.headers['X-Api-Key'] = dotenv.env['CITY_API_KEY'];
  }

  Future<Map<String, dynamic>> getCityCoordinates(String cityName) async {
    try {
      final response = await _dio.get(
        'https://api.api-ninjas.com/v1/city?name=$cityName',
      );

      if (response.statusCode == 200) {
        return response.data[0];
      } else {
        throw Exception(
            'Erreur lors de la récupération des données : ${response.statusCode}');
      }
    } catch (e) {
      throw ('Erreur : $e');
    }
  }
}
