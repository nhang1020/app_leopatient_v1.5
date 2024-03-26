import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ShowCaseView extends StatelessWidget {
  ShowCaseView(
      {super.key,
      required this.globalKey,
      required this.title,
      required this.description,
      required this.child,
      this.shapeBorder = const CircleBorder()});

  final GlobalKey globalKey;
  final String title;
  final String description;
  final Widget child;
  final ShapeBorder shapeBorder;

  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: globalKey,
      title: title,
      description: description,
      targetShapeBorder: shapeBorder,
      child: child,
    );
  }
}
