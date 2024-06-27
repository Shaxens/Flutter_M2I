import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tintin/providers/reading_list_provider.dart';
import 'package:tintin/screens/albums_master.dart';
import 'package:tintin/themes/dark_theme.dart';
import 'package:tintin/themes/light_theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ReadingListProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tintin',
      theme: AppThemeLight.themeData,
      darkTheme: AppThemeDark.themeData,
      themeMode: ThemeMode.system,
      home: const AlbumMaster(),
    );
  }
}
