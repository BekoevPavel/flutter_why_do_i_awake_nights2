import 'package:flutter_why_do_i_awake_nights1/domain/entities/message_entity.dart';

abstract class ChatRepository {
  Future<void> addMessage(
      {String? message, List<String>? imagesUrl, required DateTime date});

  Stream<List<MessageEntity>> getMessage();
}
