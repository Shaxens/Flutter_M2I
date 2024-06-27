import 'package:flutter/material.dart';
import 'package:tintin/models/album.dart';

class AlbumPreview extends StatelessWidget {
  const AlbumPreview({
    super.key,
    required this.album,
    this.isInReadingList = false,
  });

  final Album album;
  final bool isInReadingList;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isInReadingList ? Colors.amber : Colors.white,
      child: ListTile(
        title: Text(album.title),
        leading: SizedBox(
          height: 100,
          child: CircleAvatar(
            backgroundImage:
                album.image.isNotEmpty ? AssetImage(album.image) : null,
            child: album.image.isEmpty
                ? const Icon(Icons.image_not_supported_outlined)
                : null,
          ),
        ),
      ),
    );
  }
}
