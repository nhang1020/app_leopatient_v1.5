import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialog and BottomSheet Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Hiển thị Dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Dialog Title'),
                  content: Text('This is a dialog.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Đóng Dialog
                        _showBottomSheet(context); // Hiển thị BottomSheet
                      },
                      child: Text('Show BottomSheet'),
                    ),
                  ],
                );
              },
            );
          },
          child: Text('Show Dialog'),
        ),
      ),
    );
  }

  // Hàm hiển thị BottomSheet
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Center(
            child: Text('This is a BottomSheet.'),
          ),
        );
      },
    );
  }
}
