import 'package:flutter/material.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/tag_entity.dart';

typedef DeleteTag<T> = void Function(T index);
typedef AddTag<T> = void Function();

typedef TagTitle<String> = Widget Function(String tag);

class FlutterTagView extends StatefulWidget {
  FlutterTagView(
      {required this.tags,
      this.minTagViewHeight = 0,
      this.maxTagViewHeight = 150,
      this.tagBackgroundColor = Colors.black12,
      this.selectedTagBackgroundColor = Colors.lightBlue,
      this.deletableTag = true,
      required this.onDeleteTag,
      required this.tagTitle,
      required this.onAddTag})
      : assert(
            tags != null,
            'Tags can\'t be empty\n'
            'Provide the list of tags');

  List<TagEntity> tags;

  Color tagBackgroundColor;

  Color selectedTagBackgroundColor;

  bool deletableTag;

  double maxTagViewHeight;

  double minTagViewHeight;

  DeleteTag<TagEntity> onDeleteTag;
  AddTag<TagEntity> onAddTag;

  TagTitle<String> tagTitle;

  @override
  _FlutterTagViewState createState() => _FlutterTagViewState();
}

class _FlutterTagViewState extends State<FlutterTagView> {
  TagEntity selectedTagIndex = TagEntity(name: '3', color: Colors.red);

  @override
  Widget build(BuildContext context) {
    return getTagView();
  }

  Widget getTagView() {
    return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: widget.minTagViewHeight,
          maxHeight: widget.maxTagViewHeight,
        ),
        child: SingleChildScrollView(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.start,
            spacing: 5.0,
            direction: Axis.horizontal,
            children: buildTags(),
          ),
        ));
  }

  List<Widget> buildTags() {
    List<Widget> tags = <Widget>[];

    for (int i = 0; i < widget.tags.length; i++) {
      tags.add(createTag(widget.tags[i]));
    }
    tags.add(addTag());

    return tags;
  }

  Widget addTag() {
    return GestureDetector(
      onTap: (() {
        widget.onAddTag();
      }),
      child: Container(
        width: 50,
        height: 25,
        decoration: BoxDecoration(
            color: Colors.green,
            border: Border.all(width: 2),
            borderRadius: BorderRadius.circular(8)),
        child: const Center(
            child: Text(
          '+',
          style: TextStyle(fontSize: 16),
        )),
      ),
    );
  }

  Widget createTag(TagEntity index) {
    return InkWell(
      onTap: () {
        setState(() {
          //TODO: Handle tag selection

          selectedTagIndex = index;
        });
      },
      child: Chip(
        backgroundColor: index.color,
        label: widget.tagTitle == null
            ? Text(index.name)
            : widget.tagTitle(index.name),
        deleteIcon: const Icon(Icons.cancel),
        onDeleted: widget.deletableTag
            ? () {
                if (widget.deletableTag) deleteTag(index);
              }
            : null,
      ),
    );
  }

  void deleteTag(TagEntity index) {
    setState(() {
      widget.tags.remove(index);
    });
  }
}
