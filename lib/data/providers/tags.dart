import 'package:flutter/material.dart';
import '../../model/tag.dart';

class Tags with ChangeNotifier {
  final List<Tag> _tags = [
    Tag(name: 'Swedbank', color: Colors.orange),
    Tag(name: 'Global Connect', color: Colors.blue),
  ];
  List<Tag> get tags {
    return [..._tags];
  }

  Tag findById(String id) {
    return _tags.firstWhere((tb) => tb.id == id);
  }

  Tag findByGuid(String guid) {
    return _tags.firstWhere((tb) => tb.guid == guid);
  }

  void addTag(Tag tag) {
    final newEntry = Tag(
        name: tag.name,
        id: DateTime.now().toString(),
        guid: DateTime.now().toString(),
        color: Colors.green);
    _tags.add(newEntry);
    notifyListeners();
  }

  void updateTagWithId(String id, Tag newEntry) {
    final entryIndex = _tags.indexWhere((tb) => tb.id == id);
    _updateTag(entryIndex, newEntry);
  }

  void updateTagWithGuid(String guid, Tag newEntry) {
    final entryIndex = _tags.indexWhere((tb) => tb.guid == guid);
    _updateTag(entryIndex, newEntry);
  }

  void deleteTagWithID(String id) {
    _tags.removeWhere((tb) => tb.id == id);
    notifyListeners();
  }

  void deleteTagWithGuid(String guid) {
    _tags.removeWhere((tb) => tb.guid == guid);
    notifyListeners();
  }

  void _updateTag(int entryIndex, Tag newEntry) {
    if (entryIndex >= 0) {
      _tags[entryIndex] = newEntry;
      notifyListeners();
    } else {}
  }
}
