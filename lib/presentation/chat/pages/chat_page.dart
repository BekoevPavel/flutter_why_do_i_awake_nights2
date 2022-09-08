import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/chat/bloc/chat_bloc.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/chat/bloc/chat_cubit.dart';

class ChatPage extends StatelessWidget {
  static const String id = 'chat_page';
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('chat page');
    context.read<ChatCubit>().test();
    context.read<ChatCubit>().updateMessage();
    return Scaffold(
      appBar: AppBar(title: const Text('Own Chat')),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
                heroTag: "btn1",
                onPressed: () {},
                child: const Icon(
                  Icons.arrow_left,
                  size: 40,
                )),
            IntrinsicWidth(
              child: const TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search Tag',
                    labelText: 'Enter a search Tag'),
              ),
            ),
            FloatingActionButton(
                heroTag: "btn2",
                onPressed: () {},
                child: const Icon(
                  Icons.arrow_right_outlined,
                  size: 40,
                )),
          ],
        ), //dsds
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocConsumer<ChatCubit, ChatState>(
            listener: (context, state) {
              if (state is UpdateMessage) {
                print('bloc lenght: ${state.mesages.length}');
              }
            },
            builder: (context, state) {
              if (state is ChatLoading) {
                return const Center(
                  child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator()),
                );
              }
              if (state is UpdateMessage) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.mesages.length,
                  itemBuilder: ((context, index) {
                    return Text(
                      'mes: ${state.mesages[index].message}',
                      style: Theme.of(context).textTheme.headline6,
                    );
                  }),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
