import 'package:flutter/material.dart';

class Tag {
  int id;
  String guid;
  String name;
  int color;

  Tag(this.name, this.id, this.guid, {this.color = 0});
}
