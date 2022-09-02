import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/auth/bloc/auth_cubit.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/auth/pages/sign_in_screen.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/calendar/widgets/calendar_widget.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/calendar/widgets/section_widget.dart';

class MainCalendarPage extends StatelessWidget {
  static const String id = 'main_calendar';
  const MainCalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Text(
              'Centember',
              style: Theme.of(context).textTheme.headline6,
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
      //dds
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              context.read<AuthCubit>().signOut();
            },
            icon: const Icon(Icons.logout))
      ]),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        //height: MediaQuery.of(context).size.height * 0.8,
        child: Center(
            child: Column(
          children: [
            CalendarWidget(),
            Divider(
              height: MediaQuery.of(context).size.height * 0.1,
              thickness: 2,
            )
          ],
        )),
      ),
    );
  }
}
