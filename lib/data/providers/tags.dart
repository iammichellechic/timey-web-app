import 'package:flutter/material.dart';
import '/data/providers/tag.dart';

class Tags with ChangeNotifier {
  final List<Tag> _tags = [
    Tag('Swedbank', 1, 'AAA-AAA-AAA-AAA-AAA', color: 2),
    Tag('Global Connect', 2, 'AAA-AAA-AAA-AAA-AAB', color: 1),
  ];
  List<Tag> get tags {
    return [..._tags];
  }

  Tag findById(int id) {
    return _tags.firstWhere((tb) => tb.id == id);
  }

  Tag findByGuid(String guid) {
    return _tags.firstWhere((tb) => tb.guid == guid);
  }

  void addTag(Tag tag) {
    final newEntry = Tag(tag.name, tag.id, tag.guid, color: tag.color);
    _tags.add(newEntry);
    notifyListeners();
  }

  void updateTagWithId(int id, Tag newEntry) {
    final entryIndex = _tags.indexWhere((tb) => tb.id == id);
    _updateTag(entryIndex, newEntry);
  }

  void updateTagWithGuid(String guid, Tag newEntry) {
    final entryIndex = _tags.indexWhere((tb) => tb.guid == guid);
    _updateTag(entryIndex, newEntry);
  }

  void deleteTagWithID(int id) {
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
    } else {
      print('....');
    }
  }
}
