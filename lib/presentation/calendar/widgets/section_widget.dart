import 'package:flutter/material.dart';

class SectionWidget extends StatelessWidget {
  final int dayNumber;
  const SectionWidget({Key? key, required this.dayNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.1,
      height: MediaQuery.of(context).size.width * 0.1,
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        border: Border.all(
          width: 2,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Text(dayNumber.toString()),
      ),
    );
  }
}
