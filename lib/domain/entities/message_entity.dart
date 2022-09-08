import 'package:cloud_firestore/cloud_firestore.dart';

class MessageEntity {
  String userID;
  String message;
  Timestamp timestamp;
  List<String>? imagesUrl;
  MessageEntity(
      {required this.message,
      required this.imagesUrl,
      required this.timestamp,
      required this.userID});
}
