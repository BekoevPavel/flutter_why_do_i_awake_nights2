import 'package:flutter/material.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/tag_entity.dart';

class TagModel extends TagEntity {
  TagModel({required super.name, required super.color});

  factory TagModel.fromFirebase(Map<String, dynamic> data) {
    return TagModel(
      name: data['name'],
      color: Color(
        int.parse(data['color']),
      ),
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'name': name,
      'color': '0xFF${color.value.toRadixString(16).substring(2, 8)}',
    };
  }
}
