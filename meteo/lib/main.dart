import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meteo/screens/city_form.dart';

void main() async {
  await dotenv.load(fileName: "../config/.env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Météo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CityForm(),
    );
  }
}
