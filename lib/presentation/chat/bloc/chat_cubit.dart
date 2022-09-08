import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_why_do_i_awake_nights1/data/chat_repository_impl.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/chat/bloc/chat_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  Stream<UpdateMessage> updateMessage() async* {
    var repos = ChatRepositoryImpl();
    print('start update');

    await for (var messages in repos.getMessage()) {
      emit(UpdateMessage(mesages: messages));
    }
  }

  Future<void> test() async {
    var repos = ChatRepositoryImpl();
    repos.getMessage().listen(
      (event) {
        emit(ChatLoading());
        emit(UpdateMessage(mesages: event));
      },
    );
  }
}
