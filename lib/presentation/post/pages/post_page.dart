import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/post_entity.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/calendar/bloc/calendar_cubit.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/post/bloc/post_cubit.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/post/bloc/post_state.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/post/states/form_provider.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/post/states/post_controller.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/post/widgets/description_widget.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/post/widgets/tags_widget.dart';

import "package:provider/provider.dart";

class PostPage extends StatelessWidget {
  PostEntity? postEntity;
  static const String id = 'post_page';
  final PostController _controller = PostController();
  PostProvider postProvider = PostProvider();
  DateTime dateTime = DateTime.now();

  PostPage({Key? key, this.postEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments is DateTime) {
      dateTime = ModalRoute.of(context)!.settings.arguments as DateTime;
    } else if (ModalRoute.of(context)!.settings.arguments is PostEntity) {
      dateTime = (ModalRoute.of(context)!.settings.arguments as PostEntity)
          .timestamp
          .toDate();
      postEntity = (ModalRoute.of(context)!.settings.arguments as PostEntity);

      postProvider.description = postEntity!.description;
      postProvider.tags = postEntity!.tags;
      postProvider.imagesUrl = postEntity!.imagesUrl;
    }

    return ChangeNotifierProvider(
      create: (context) => postProvider,
      child: BlocConsumer<PostCubit, PostState>(
        listener: (context, state) {
          // TODO: implement listener

          if (state is PostLoadedState) {
            context.read<CalendarCubit>().updateMonth(dateTime.month);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is PostLoadingState) {
            return const Center(
                child: SizedBox(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator()));
          }
          return Scaffold(
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 15),
                  child: FloatingActionButton(
                    heroTag: "btn5",
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      postProvider.clear();
                      if (postEntity != null) {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                title: const Text('Confirm Deleting'),
                                content: Column(
                                  children: [
                                    ElevatedButton(
                                      child: const Text('Delete Post'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        context
                                            .read<PostCubit>()
                                            .removePost(postEntity!);
                                      },
                                    ),
                                    ElevatedButton(
                                      child: const Text('Back'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }));
                        //context.read<PostCubit>().removePost(postEntity!);
                      }

                      // if (postEntity != null)
                      //   context.read<CalendarCubit>().removePost(postEntity!);
                    },
                    child: const Icon(
                      Icons.clear,
                      size: 40,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: FloatingActionButton(
                    heroTag: "btn3",
                    onPressed: () async {
                      if (postEntity != null) {
                        if (postProvider.description != null ||
                            postProvider.tags != null ||
                            postProvider.imagesUrl != null) {
                          context.read<PostCubit>().editPost(
                              descriptoin: postProvider.description ?? '',
                              dateTime: dateTime,
                              tags: postProvider.tags,
                              imagesUrl: postProvider.imagesUrl,
                              postID: postEntity!.postID);
                        }
                      } else if (postProvider.description != null ||
                          postProvider.tags != null ||
                          postProvider.imagesUrl != null) {
                        context.read<PostCubit>().addPost(
                            descriptoin: postProvider.description ?? '',
                            tags: postProvider.tags,
                            imagesUrl: postProvider.imagesUrl,
                            dateTime: dateTime);
                      }

                      FocusScope.of(context).unfocus();
                    },
                    child: const Icon(
                      Icons.save,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
            appBar: AppBar(
              title: Column(
                children: [
                  Text(
                      '${_controller.getDayName(dateTime.weekday)} — ${_controller.getDayName(dateTime.weekday + 1)} '),
                  Text(
                      '${dateTime.day} — ${DateTime(dateTime.year, dateTime.month, dateTime.day + 1).day}')
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Consumer<PostProvider>(
                      builder: ((context, value, child) {
                        return DescriptionWidget();
                      }),
                    ),
                    const Divider(
                      height: 8,
                      thickness: 3,
                    ),
                    Consumer<PostProvider>(
                      builder: ((context, value, child) {
                        return TagsWidget(
                          tags: value.tags,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
