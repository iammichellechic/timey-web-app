import 'package:flutter/material.dart';

import '../../model/filterTag.dart';

class FilterTags {
  final List<FilterTag> _allFilterTags = [
    FilterTag(
      label: '.Net',
      isSelected: false,
      color: Colors.green,
    ),
    FilterTag(
      label: 'DevOps',
      isSelected: false,
      color: Colors.red,
    ),
   FilterTag(
      label: 'Flutter',
      isSelected: false,
      color: Colors.blue,
    ),
    FilterTag(
      label: 'Infrastracture',
      isSelected: false,
      color: Colors.orange,
    ),
    FilterTag(
      label: 'Sql',
      isSelected: false,
      color: Colors.purple,
    ),
    FilterTag(
      label: 'React',
      isSelected: false,
      color: Colors.lightBlue,
    ),
  ];

   List<FilterTag> get all {
    return [..._allFilterTags];
  }

  FilterTag findById(int id) {
    return _allFilterTags.firstWhere((tb) => tb.id == id);
  }

}