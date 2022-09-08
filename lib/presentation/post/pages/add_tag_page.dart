import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/tag_entity.dart';
import 'package:input_history_text_field/input_history_text_field.dart';

class AddTagPage extends StatelessWidget {
  static const String id = 'add_tag';
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);
  TextEditingController _textController =
      TextEditingController(text: "Just did't sleep");

  AddTagPage({Key? key}) : super(key: key);
  void changeColor(Color color) {
    //setState(() => pickerColor = color);
    pickerColor = color;
  }

  @override
  Widget build(BuildContext context) {
    StreamController<Color> colorStream = StreamController();
    StreamController<String> textStream = StreamController();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Tag'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context)
                .pop(TagEntity(name: _textController.text, color: pickerColor)),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: FloatingActionButton(
              heroTag: "btn4",
              onPressed: () {
                textStream.sink.add(_textController.text);
              },
              child: const Icon(
                Icons.save,
                size: 40,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: (() {
                    showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          title: const Text('Pick a color!'),
                          content: SingleChildScrollView(
                              child: HueRingPicker(
                            displayThumbColor: true,
                            pickerColor: pickerColor,
                            enableAlpha: true,
                            onColorChanged: (value) => changeColor(value),
                          )),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('Got it'),
                              onPressed: () {
                                //setState(() => currentColor = pickerColor);
                                colorStream.sink.add(pickerColor);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      }),
                    );
                  }),
                  child: Column(
                    children: [
                      const Text('Click below to change Color of Tag'),
                      StreamBuilder<Object>(
                          stream: colorStream.stream,
                          builder: (context, snapshot) {
                            return Container(
                              width: 300,
                              height: 60,
                              decoration: BoxDecoration(
                                color: pickerColor,
                                border: Border.all(width: 2),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: StreamBuilder<Object>(
                                    stream: textStream.stream,
                                    builder: (context, snapshot) {
                                      return Text(_textController.text,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5);
                                    }),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 50,
                child: InputHistoryTextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a search Tag',
                      labelText: 'Enter a search Tag'),
                  textAlign: TextAlign.center,
                  textEditingController: _textController,
                  //autofocus: false,
                  //keyboardType: TextInputType.multiline,

                  historyKey: "01",
                  lockItems: const ['Flutter', 'Rails', 'React', 'Vue'],
                  listStyle: ListStyle.Badge,
                  onEditingComplete: () {
                    textStream.sink.add(_textController.text);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
