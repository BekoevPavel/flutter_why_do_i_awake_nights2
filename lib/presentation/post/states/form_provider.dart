import 'package:flutter/material.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/tag_entity.dart';

class PostProvider extends ChangeNotifier {
  String? description;
  List<TagEntity>? tags;
  List<String>? imagesUrl;

  void clear() {
    tags = null;
    description = null;
    imagesUrl = null;
    notifyListeners();
  }

  PostProvider({this.description, this.imagesUrl, this.tags});
}
