import 'package:flutter/material.dart';

class Tag {
  String? id;
  String? guid;
  String? name;
  Color? color;

  Tag({this.name, this.id, this.guid, this.color});

  Tag copy({
    String? name,
    Color? color,
    String? id,
    String? guid,
  }) =>
      Tag(
        name: name ?? this.name,
        color: color ?? this.color,
        id: id ?? this.id,
        guid: guid ?? this.id,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tag &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          color == other.color &&
          guid == other.guid;

  @override
  int get hashCode => name.hashCode ^ color.hashCode ^ guid.hashCode;
}
