import 'dart:async';

import 'package:app/src/app.dart';
import 'package:app/src/controllers/localData.dart';
import 'package:app/src/models/User_Pass.dart';
import 'package:app/src/controllers/notification_manager/notification_helper.dart';
import 'package:app/src/views/screens/auth/login_screen.dart';
import 'package:app/src/views/screens/home/widgets/notificationCenter.dart';
import 'package:app/src/views/widgets/loadingPage.dart';
import 'package:app/src/views/widgets/rootWidget.dart';
import 'package:flutter/material.dart';

class SplashScreenLoader extends StatefulWidget {
  const SplashScreenLoader({super.key});

  @override
  State<SplashScreenLoader> createState() => _SplashScreenLoaderState();
}

class _SplashScreenLoaderState extends State<SplashScreenLoader> {
  LocalData _localData = LocalData();
  User_Pass? taiKhoan;

  Future continueLogin() async {
    taiKhoan = await _localData.Shared_GetAccount();
    // setState(() {});

    if (taiKhoan != null) {
      listenNotification();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => RootWidget()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  listenNotification() =>
      NotificationHelper.onNotification.stream.listen(onClickedNotification);
  onClickedNotification(String? payload) {
    try {
      if (payload != null && payload != "") {
        return MyApp.navigatorKey.currentState?.push(MaterialPageRoute(
          builder: (context) => Scaffold(
            body: NotifitionDialog(
              selectedIndex: 0,
            ),
          ),
        ));
        // return MyApp.navigatorKey.currentState ? showDialog(
        //   context: context,
        //   builder: (context) => NotifitionDialog(
        //     selectedIndex: 0,
        //   ),
        // );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    continueLogin();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Loading();
  }
}
