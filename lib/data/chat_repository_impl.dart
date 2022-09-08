import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_why_do_i_awake_nights1/data/models/message_model.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/chat_repository.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/message_entity.dart';

class ChatRepositoryImpl implements ChatRepository {
  @override
  Future<void> addMessage(
      {String? message,
      List<String>? imagesUrl,
      required DateTime date}) async {
    try {
      await FirebaseFirestore.instance.collection('messages').add({
        'timestamp': Timestamp.fromDate(date),
        'userID': FirebaseAuth.instance.currentUser!.uid,
        'message': message,
        'imagesUrl': imagesUrl,
        'messageID': ''
      }).then((docRef) {
        docRef.update({'messageID': docRef.id});
      });
    } catch (e, pri) {
      print('e: $e , pri: $pri');
    }
  }

  @override
  Stream<List<MessageEntity>> getMessage() async* {
    var strim = FirebaseFirestore.instance.collection('messages').snapshots();

    await for (var s in strim) {
      List<MessageModel> models = [];

      for (var d in s.docs) {
        models.add(MessageModel(
            message: d['message'],
            imagesUrl: [],
            timestamp: Timestamp.now(),
            userID: 'userID'));
      }

      yield models;
    }
  }
}
