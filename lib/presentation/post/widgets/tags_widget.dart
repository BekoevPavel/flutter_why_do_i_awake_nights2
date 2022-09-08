import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_why_do_i_awake_nights1/data/models/tag_model.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/post_entity.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/tag_entity.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/post/pages/add_tag_page.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/post/states/form_provider.dart';

import ' flutter_tag_view.dart';

class TagsWidget extends StatefulWidget {
  List<TagEntity>? tags;

  TagsWidget({Key? key, this.tags}) : super(key: key);

  @override
  State<TagsWidget> createState() => _TagsWidgetState();
}

class _TagsWidgetState extends State<TagsWidget> {
  bool absorbing = true;

  @override
  void initState() {
    if (context.read<PostProvider>().tags != null) {
      widget.tags = (context.read<PostProvider>().tags!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () {
                  setState(() {
                    absorbing = !absorbing;
                  });
                },
                icon: Icon(Icons.edit)),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: AbsorbPointer(
              absorbing: absorbing,
              child: FlutterTagView(
                onAddTag: () async {
                  TagEntity tag = await Navigator.of(context)
                      .pushNamed(AddTagPage.id) as TagEntity;

                  if (tag != null) {
                    setState(() {
                      if (widget.tags == null) {
                        widget.tags = <TagEntity>[];
                      }

                      widget.tags?.add(TagModel(
                          name: tag.toModel().name,
                          color: tag.toModel().color));

                      context.read<PostProvider>().tags = widget.tags;
                    });
                  }
                },
                tags: widget.tags ?? [],
                maxTagViewHeight: 100,
                deletableTag: true,
                onDeleteTag: (s) {
                  print('s: ${s}');
                },
                tagTitle: ((tag) => Text(tag)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
