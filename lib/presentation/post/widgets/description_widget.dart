import 'package:flutter/material.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/post_entity.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/post/states/form_provider.dart';
import "package:provider/provider.dart";

class DescriptionWidget extends StatelessWidget {
  final PostEntity? postEntity;
  final TextEditingController _textEditingController = TextEditingController();
  DescriptionWidget({Key? key, this.postEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _textEditingController.text =
        context.read<PostProvider>().description ?? '';
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Description', style: Theme.of(context).textTheme.headline6),
              IconButton(
                  onPressed: () {
                    context.read<PostProvider>().description =
                        _textEditingController.text;

                    FocusScope.of(context).unfocus();
                  },
                  icon: const Icon(Icons.save)),
            ],
          ),
          IntrinsicHeight(
            child: TextField(
              controller: _textEditingController,
              onEditingComplete: (() {}),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
              autofocus: false,
              keyboardType: TextInputType.multiline,
              maxLength: null,
              maxLines: 12,
              minLines: 7,
            ),
          ),
        ],
      ),
    );
  }
}
