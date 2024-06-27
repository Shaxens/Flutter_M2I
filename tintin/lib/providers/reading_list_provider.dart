import 'package:flutter/foundation.dart';

class ReadingListProvider extends ChangeNotifier {
  final List<int> _readingListIds = [];

  List<int> get readingListIds => _readingListIds;

  void addAlbum(int albumId) {
    if (!_readingListIds.contains(albumId)) {
      _readingListIds.add(albumId);
      notifyListeners();
    }
  }

  void removeAlbum(int albumId) {
    if (_readingListIds.contains(albumId)) {
      _readingListIds.remove(albumId);
      notifyListeners();
    }
  }

  bool isInReadingList(int albumId) {
    return _readingListIds.contains(albumId);
  }

  void clearReadingList() {
    _readingListIds.clear();
    notifyListeners();
  }
}
