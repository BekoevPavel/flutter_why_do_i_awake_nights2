import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_why_do_i_awake_nights1/data/main_repository_impl.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/auth/bloc/auth_cubit.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/auth/pages/sign_in_screen.dart';

import 'package:flutter_why_do_i_awake_nights1/presentation/calendar/bloc/calendar_cubit.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/calendar/bloc/calendar_state.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/calendar/widgets/calendar_widget.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/chat/pages/chat_page.dart';

class MainCalendarPage extends StatelessWidget {
  static const String id = 'main_calendar';
  DateTime currentTime = DateTime.now();

  MainCalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainRepositoryImpl mainRepositoryImpl = MainRepositoryImpl();
    // mainRepositoryImpl
    //     .getPost(Timestamp.fromDate(DateTime.now()))
    //     .listen((event) {
    //   print(event.description);
    //   print('description: ${event.description}');
    //   print('tags: ${event.tags}');
    // });

    return BlocConsumer<CalendarCubit, CalendarState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is CalendarLoadiang) {
          return const Center(
              child: SizedBox(
                  width: 200, height: 200, child: CircularProgressIndicator()));
        }

        return Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 30),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                    heroTag: "btn1",
                    onPressed: () {
                      currentTime = DateTime(currentTime.year,
                          currentTime.month - 1, currentTime.day);
                      context
                          .read<CalendarCubit>()
                          .updateMonth(currentTime.month);
                    },
                    child: const Icon(
                      Icons.arrow_left,
                      size: 40,
                    )),
                Text(
                  state.monthName,
                  style: Theme.of(context).textTheme.headline6,
                ),
                FloatingActionButton(
                    heroTag: "btn2",
                    onPressed: () {
                      currentTime = DateTime(currentTime.year,
                          currentTime.month + 1, currentTime.day);
                      context
                          .read<CalendarCubit>()
                          .updateMonth(currentTime.month);
                    },
                    child: const Icon(
                      Icons.arrow_right_outlined,
                      size: 40,
                    )),
              ],
            ), //dsds
          ),
          //dds
          appBar: AppBar(
              title: Text(currentTime.year.toString()),
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(ChatPage.id);
                  },
                  icon: const Icon(Icons.chat)),
              actions: [
                IconButton(
                    onPressed: () {
                      context.read<AuthCubit>().signOut().then((value) =>
                          Navigator.of(context)
                              .pushReplacementNamed(SignInScreen.id));
                    },
                    icon: const Icon(Icons.logout))
              ]),
          body: Container(
            padding: const EdgeInsets.all(8.0),
            //height: MediaQuery.of(context).size.height * 0.8,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CalendarWidget(
                    currentDate: currentTime,
                    posts: state.posts,
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
