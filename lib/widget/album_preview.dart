import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tintin/models/album.dart';
import 'package:tintin/providers/reading_list_provider.dart';

class AlbumPreview extends StatelessWidget {
  const AlbumPreview({
    super.key,
    required this.album,
  });

  final Album album;

  @override
  Widget build(BuildContext context) {
    return Consumer<ReadingListProvider>(
      builder: (context, provider, _) => Card(
        color: provider.isInReadingList(album.numero)
            ? Colors.lightBlue[50]
            : Colors.white,
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
          trailing: IconButton(
            icon: Icon(provider.isInReadingList(album.numero)
                ? Icons.playlist_add_check
                : Icons.search),
            color: provider.isInReadingList(album.numero) ? Colors.blue : null,
            onPressed: () {
              if (provider.isInReadingList(album.numero)) {
                provider.removeAlbum(album.numero);
              } else {
                provider.addAlbum(album.numero);
              }
            },
          ),
        ),
      ),
    );
  }
}
