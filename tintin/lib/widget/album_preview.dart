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
    final theme = Theme.of(context);
    return Consumer<ReadingListProvider>(
      builder: (context, provider, _) => Card(
        color: provider.isInReadingList(album.numero)
            ? theme.colorScheme.secondary
            : theme.cardTheme.color,
        child: ListTile(
          tileColor: provider.isInReadingList(album.numero)
              ? theme.colorScheme.secondary
              : theme.colorScheme.onPrimary,
          title: Text(
            album.title,
            style: TextStyle(
              color: provider.isInReadingList(album.numero)
                  ? theme.colorScheme.onSecondary
                  : theme.textTheme.bodyLarge!.color,
            ),
          ),
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
            color: provider.isInReadingList(album.numero)
                ? theme.colorScheme.onSecondary
                : null,
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
