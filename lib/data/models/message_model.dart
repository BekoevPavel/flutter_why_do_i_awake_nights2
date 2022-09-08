import 'package:flutter_why_do_i_awake_nights1/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel(
      {required super.message,
      required super.imagesUrl,
      required super.timestamp,
      required super.userID});

  factory MessageModel.fromFirebase(Map<String, dynamic> data) {
    List<String>? imagesUrl;

    if (data['imagesUrl'] != null) {
      imagesUrl = (data['imagesUrl'] as List).map((e) => e.toString()).toList();
    }

    return MessageModel(
        userID: data['userID'],
        message: data['message'],
        imagesUrl: imagesUrl,
        timestamp: data['timestamp']);
  }
}
