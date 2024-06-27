import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tintin/models/album.dart';
import 'package:tintin/providers/reading_list_provider.dart';

class AlbumDetails extends StatelessWidget {
  final Album album;

  const AlbumDetails({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    final readingListProvider = Provider.of<ReadingListProvider>(context);
    final isInReadingList = readingListProvider.isInReadingList(album.numero);

    return Scaffold(
      appBar: AppBar(
        title: Text(album.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Album n° : ${album.numero}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.all(16.0)),
            Text('Résumé : ${album.resume}'),
            Padding(padding: EdgeInsets.all(32.0)),
            Text(
              'Année de parution : ${album.year}',
            ),
            if (album.yearInColor != null) ...[
              Text(
                'Année de parution en couleur : ${album.yearInColor}',
              ),
            ],
            if (album.image.isNotEmpty) ...[
              Padding(padding: EdgeInsets.all(8.0)),
              Image.asset(
                album.image,
                height: 300,
                fit: BoxFit.cover,
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isInReadingList) {
            readingListProvider.removeAlbum(album.numero);
          } else {
            readingListProvider.addAlbum(album.numero);
          }
          Navigator.pop(context);
        },
        backgroundColor: Colors.lightBlue,
        child: const Icon(
          Icons.playlist_add,
          color: Colors.white,
        ),
      ),
    );
  }
}
