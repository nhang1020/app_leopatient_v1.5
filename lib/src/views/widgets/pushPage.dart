import 'package:app/src/views/widgets/button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PushPage extends StatelessWidget {
  PushPage({super.key, required this.page, this.title});
  Widget page;
  String? title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leadingWidth: 60,
        leading: Column(
          children: [
            Card(
              elevation: 10,
              margin: EdgeInsets.only(top: 10, left: 10),
              child: MyButton(
                color: Colors.transparent,
                icon: Icon(Icons.keyboard_arrow_left_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
        title: Text(
          title ?? "",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).textTheme.displayLarge!.color,
              fontWeight: FontWeight.w500),
        ),
        elevation: 0,
      ),
      body: page,
    );
  }
}
