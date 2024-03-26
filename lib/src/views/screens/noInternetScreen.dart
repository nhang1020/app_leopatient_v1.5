import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          child: Column(
            children: [
              Icon(
                Icons.wifi_off,
                color: myColor,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Không có kết nối mạng',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              MyButton(
                icon: Icon(
                  Icons.replay_outlined,
                  color: Colors.white,
                ),
                label: 'Thử lại',
                onPressed: () {
                  try {
                    Restart.restartApp();
                  } catch (e) {
                    print(e);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
