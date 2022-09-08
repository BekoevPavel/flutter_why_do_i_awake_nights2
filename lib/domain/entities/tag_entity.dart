import 'package:flutter/material.dart';
import 'package:flutter_why_do_i_awake_nights1/data/models/tag_model.dart';

class TagEntity {
  Color color;
  String name;
  TagEntity({required this.name, required this.color});

  TagModel toModel() {
    return TagModel(name: name, color: color);
  }
}
