import 'package:app/src/utils/variables.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EmptyList extends StatelessWidget {
  EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/pictures/empty_box_24px.png",
                width: 100, color: myColor),
            SizedBox(height: 10),
            Container(
              constraints: BoxConstraints(maxWidth: 250),
              child: Text(
                "Danh sách trống",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
