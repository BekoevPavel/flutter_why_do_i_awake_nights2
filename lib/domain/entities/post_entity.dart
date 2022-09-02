import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/tag_entity.dart';

class PostEntity {
  String postID;
  String userID;
  String description;
  Timestamp timestamp;
  List<TagEntity>? tags;
  List<String>? imagesUrl;

  PostEntity(
      {required this.userID,
      required this.description,
      this.imagesUrl,
      required this.postID,
      this.tags,
      required this.timestamp});
}
