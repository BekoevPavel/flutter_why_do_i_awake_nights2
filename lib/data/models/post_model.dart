import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_why_do_i_awake_nights1/data/models/tag_model.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/post_entity.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/tag_entity.dart';

class PostModel extends PostEntity {
  PostModel(
      {required super.userID,
      required super.description,
      required super.imagesUrl,
      required super.postID,
      required super.tags,
      required super.timestamp});
  factory PostModel.fromFirebase(Map<String, dynamic> data) {
    List<TagEntity>? tags;
    List<String>? imagesUrl;
    if (data['tags'] != null) {
      tags = (data['tags'] as List).map((event) {
        return TagModel.fromFirebase(event);
      }).toList();
    }
    if (data['imagesUrl'] != null) {
      imagesUrl = (data['imagesUrl'] as List).map((e) => e.toString()).toList();
    }

    return PostModel(
        userID: data['userID'],
        description: data['description'],
        imagesUrl: imagesUrl,
        postID: data['postID'],
        tags: tags,
        timestamp: data['timestamp']);
  }
}
