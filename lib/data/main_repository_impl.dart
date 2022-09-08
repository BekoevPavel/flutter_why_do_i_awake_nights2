import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_why_do_i_awake_nights1/core/failure.dart';
import 'package:flutter_why_do_i_awake_nights1/data/models/post_model.dart';

import 'package:flutter_why_do_i_awake_nights1/data/models/tag_model.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/tag_entity.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/main_repository.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/post_entity.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/post/pages/post_page.dart';

class MainRepositoryImpl implements MainRepository {
  @override
  Future<void> addPost(
      {required String descriptoin,
      List<String>? imagesUrl,
      List<TagModel>? tags,
      required Timestamp timestamp}) async {
    try {
      await FirebaseFirestore.instance.collection('posts').add({
        'timestamp': timestamp,
        'userID': FirebaseAuth.instance.currentUser!.uid,
        'description': descriptoin,
        'imagesUrl': imagesUrl,
        'postID': '',
        'tags': tags?.map((e) => e.toFirebase()).toList()
      }).then((docRef) {
        docRef.update({'postID': docRef.id});
      });
    } catch (e, pri) {
      print('e: $e , pri: $pri');
    }
  }

  @override
  Stream<PostEntity> getPost(DateTime dateTime) async* {
    await for (var element
        in FirebaseFirestore.instance.collection('posts').snapshots()) {
      if (element.docs.isNotEmpty) {
        List<PostEntity> lst = [];

        for (var i in element.docs) {
          lst.add(PostModel.fromFirebase(i.data()));
        }

        var res = lst.where((element) {
          if (element.timestamp.toDate().day == dateTime.day &&
              element.timestamp.toDate().month == dateTime.month &&
              element.timestamp.toDate().year == dateTime.year) {
            return true;
          }
          return false;
        }).toList();

        if (res.isNotEmpty) {
          yield res.first;
        }

        //yield lst;
      }
    }
  }

  @override
  Future<void> removePost(PostEntity postEntity) async {
    CollectionReference users = FirebaseFirestore.instance.collection('posts');

    postEntity.postID;

    return users
        .doc(postEntity.postID)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  // Stream<String> myStream() async* {
  //   await for (var element
  //       in FirebaseFirestore.instance.collection('posts').snapshots()) {
  //     yield PostModel.fromFirebase(element.docs.first.data())
  //             .tags
  //             ?.first
  //             .name ??
  //         '';
  //   }
  // }

  @override
  Future<AuthFailure?> singIn(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print('saccess');
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      var doc = await users.doc(credential.user?.uid).get();

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      //---
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .update({'data': 'mydata'});
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return AuthFailure.userNotFound;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return AuthFailure.wrongPassword;
      }
    }
  }

  @override
  Future<AuthFailure?> singOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<AuthFailure?> singUp(
      {required String email,
      required String userName,
      required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        'userID': credential.user!.uid,
        'email': credential.user!.email,
        'username': userName,
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return AuthFailure.weakPassword;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return AuthFailure.emailAlreadyInUse;
      }
    } catch (e) {
      print('reeriir $e');
    }
  }

  @override
  Future<List<PostEntity>> getAllPost() async {
    List<PostEntity> lst = [];

    await for (var element
        in FirebaseFirestore.instance.collection('posts').snapshots()) {
      if (element.docs.isNotEmpty) {
        for (var i in element.docs) {
          var model = PostModel.fromFirebase(i.data());
          print('userID: ${FirebaseAuth.instance.currentUser!.uid} ');
          if (model.userID == FirebaseAuth.instance.currentUser!.uid) {
            lst.add(model);
          }
        }
        print('lenght: ${lst.length}');

        for (var i in lst) {
          print('desc: ${i.description}');
        }

        return lst;
      } else {
        return [];
      }
    }

    return lst;
  }

  @override
  Future<void> editPost(
      {required String descriptoin,
      List<String>? imagesUrl,
      List<TagEntity>? tags,
      required Timestamp timestamp,
      required String postID}) async {
    await FirebaseFirestore.instance.collection('posts').doc(postID).update({
      'timestamp': timestamp,
      'userID': FirebaseAuth.instance.currentUser!.uid,
      'description': descriptoin,
      'imagesUrl': imagesUrl,
      // 'postID': postEntity.postID,
      'tags': tags?.map((e) => e.toModel().toFirebase()).toList()
    });
  }
}
