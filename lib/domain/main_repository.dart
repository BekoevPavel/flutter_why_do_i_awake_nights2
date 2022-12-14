import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_why_do_i_awake_nights1/core/failure.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/post_entity.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/tag_entity.dart';

import '../data/models/tag_model.dart';
import 'package:dartz/dartz.dart';

abstract class MainRepository {
  Future<AuthFailure?> singIn(
      {required String email, required String password});
  Future<AuthFailure?> singUp(
      {required String email,
      required String userName,
      required String password});
  Future<AuthFailure?> singOut();

  Future<void> addPost(
      {required String descriptoin,
      List<String>? imagesUrl,
      List<TagModel>? tags,
      required Timestamp timestamp});
  Stream<PostEntity> getPost(DateTime dateTime);

  Future<void> removePost(PostEntity postEntity);

  Future<List<PostEntity>> getAllPost();

  Future<void> editPost(
      {required String descriptoin,
      List<String>? imagesUrl,
      List<TagEntity>? tags,
      required Timestamp timestamp,
      required String postID});
}
