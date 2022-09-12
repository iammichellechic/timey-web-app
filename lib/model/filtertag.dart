import 'package:flutter/material.dart';

class FilterTag {
  int? id;
  String? label;
  Color? color;
  bool? isSelected;

  FilterTag({
    this.id,
    required this.label,
    required this.color,
    this.isSelected = false,
  });

  FilterTag copy({
    String? label,
    Color? color,
    bool? isSelected,
  }) =>
      FilterTag(
        label: label ?? this.label,
        color: color ?? this.color,
        isSelected: isSelected ?? this.isSelected,
      );

  @override
  int get hashCode => label.hashCode ^ color.hashCode ^ isSelected.hashCode;
}
