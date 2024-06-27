import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tintin/models/album.dart';

class AlbumService {
  static Future<List<Album>> fetchAlbums() async {
    final String response =
        await rootBundle.loadString('assets/data/albums.json');
    final data = jsonDecode(response) as List;
    return data.map((json) => Album.fromJson(json)).toList();
  }
}
