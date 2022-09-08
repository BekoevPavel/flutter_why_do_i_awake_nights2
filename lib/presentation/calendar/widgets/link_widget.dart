import 'package:flutter/material.dart';
import 'package:flutter_why_do_i_awake_nights1/data/main_repository_impl.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/post_entity.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/calendar/states/calendar_state.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/post/pages/post_page.dart';

class LinkWidget extends StatelessWidget {
  final double? k;
  final String? type;
  final DateTime dateTime;
  final PostEntity? post;
  const LinkWidget(
      {Key? key, this.k, this.type, required this.dateTime, this.post})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type != null) {
      String url = type == 'line' ? "assets/link.png" : "assets/link_break.png";
      Color color =
          type == 'line' ? Colors.cyanAccent.withRed(200) : Colors.redAccent;

      return StreamBuilder<PostEntity>(
          stream: MainRepositoryImpl().getPost(dateTime),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                CalendarController()
                    .equelMonth(snapshot.data!.timestamp.toDate(), dateTime)) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(PostPage.id, arguments: snapshot.data);
                },
                child: Image.asset("assets/link_break.png",
                    width: MediaQuery.of(context).size.height * (k ?? 1) * 0.04,
                    height:
                        MediaQuery.of(context).size.height * (k ?? 1) * 0.04,
                    color: Colors.redAccent),
              );
            }

            return GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(PostPage.id, arguments: dateTime);
              },
              child: Image.asset('assets/link.png',
                  width: MediaQuery.of(context).size.height * (k ?? 1) * 0.04,
                  height: MediaQuery.of(context).size.height * (k ?? 1) * 0.04,
                  color: color),
            );
          });
    }
    return SizedBox(
      width: MediaQuery.of(context).size.height * (k ?? 1) * 0.04,
      height: MediaQuery.of(context).size.height * (k ?? 1) * 0.04,
    );
  }
}

class LinkWidget1 extends StatelessWidget {
  final double? k;
  final String? type;
  final DateTime dateTime;
  final PostEntity? post;
  const LinkWidget1(
      {Key? key, this.k, this.type, required this.dateTime, this.post})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type != null) {
      if (post != null) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(PostPage.id, arguments: post);
          },
          child: Image.asset('assets/link_break.png',
              width: MediaQuery.of(context).size.height * (k ?? 1) * 0.04,
              height: MediaQuery.of(context).size.height * (k ?? 1) * 0.04,
              color: Colors.redAccent),
        );
      }
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(PostPage.id, arguments: dateTime);
        },
        child: Image.asset('assets/link.png',
            width: MediaQuery.of(context).size.height * (k ?? 1) * 0.04,
            height: MediaQuery.of(context).size.height * (k ?? 1) * 0.04,
            color: Colors.cyanAccent.withRed(200)),
      );
    }
    return SizedBox(
      width: MediaQuery.of(context).size.height * (k ?? 1) * 0.04,
      height: MediaQuery.of(context).size.height * (k ?? 1) * 0.04,
    );
  }
}
