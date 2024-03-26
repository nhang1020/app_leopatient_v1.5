import 'package:app/src/utils/variables.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, this.title});
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Image.asset("assets/icons/questions_96px.png", color: myColor),
        ),
        Text(
          title ?? "",
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
