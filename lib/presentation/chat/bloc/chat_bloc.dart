import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/message_entity.dart';

class ChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class UpdateMessage extends ChatState {
  List<MessageEntity> mesages;
  UpdateMessage({required this.mesages});
}
