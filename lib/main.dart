import 'package:app/src/firebase/firebase_options.dart';
import 'package:app/src/app.dart';
import 'package:app/src/controllers/notification_manager/firebase_notification.dart';
import 'package:app/src/views/screens/noInternetScreen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // var connectivityResult = await (Connectivity().checkConnectivity());
  // bool connect = false;
  // if (connectivityResult == ConnectivityResult.wifi ||
  //     connectivityResult == ConnectivityResult.mobile) {
  //   connect = true;
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  //   await FirebaseMessageApi().initNotification();
  // }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessageApi().initNotification();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final indexTheme = prefs.getInt('themeMode') ?? 0;
  int indexColor = prefs.getInt('theme') ?? 0;
  runApp(
      // connect
      //     ?
      MyApp(indexTheme: indexTheme, indexColor: indexColor)
      // : MaterialApp(
      //     debugShowCheckedModeBanner: false,
      //     home: NoInternetScreen(),
      // ),
      );
}
