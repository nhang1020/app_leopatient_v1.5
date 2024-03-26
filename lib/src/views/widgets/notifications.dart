import 'package:app/src/utils/variables.dart';
import 'package:flutter/material.dart';

class MyNotifications {
  SnackBar successSnackBar(String content) {
    return SnackBar(
      backgroundColor: myColor,
      content: Text(
        ' ${content}',
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ), // Width of the SnackBar.
      duration: Duration(seconds: 2),
      padding: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      // elevation: 20,
      // width: 200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  SnackBar errorSnackBar(String content) {
    return SnackBar(
      backgroundColor: Colors.red.shade300,
      duration: Duration(seconds: 2),
      content: Text(
        ' ${content}',
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ), // Width of the SnackBar.
      padding: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  SnackBar warningSnackBar(String content) {
    return SnackBar(
      backgroundColor: Colors.white,
      content: Text(
        '⚠ ${content}',
        style: TextStyle(color: Colors.blueAccent),
        textAlign: TextAlign.center,
      ), // Width of the SnackBar.
      duration: Duration(seconds: 2),
      padding: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
