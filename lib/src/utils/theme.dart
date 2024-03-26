import 'package:app/src/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<ThemeMode> listMode = [ThemeMode.system, ThemeMode.light, ThemeMode.dark];

class ThemeProvider extends ChangeNotifier {
  int indexThemeInit = 0;
  ThemeProvider(int indexTheme, int indexColor) {
    if (indexTheme == 0) {
      themeMode = ThemeMode.system;
    } else if (indexTheme == 1) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    toggleColor(indexColor);
    indexThemeInit = indexTheme;
    indexCl = indexColor;
    myColor = isDarkMode ? darkThemes[indexColor] : lightThemes[indexColor];
  }
  ThemeMode themeMode = ThemeMode.light;

  int indexCl = 0;
  bool get isSysDark =>
      themeMode == ThemeMode.system &&
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  toggleColor(int index, {BuildContext? context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('theme', index);
    indexCl = index;
    myColor = isDarkMode || isSysDark ? darkThemes[index] : lightThemes[index];

    notifyListeners();
  }

  toggleTheme(int mode, int index, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mode == 0) {
      themeMode = ThemeMode.system;
    } else if (mode == 1) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    prefs.setInt('themeMode', mode);
    myColor = isDarkMode || isSysDark ? darkThemes[index] : lightThemes[index];
    notifyListeners();
  }
}

class ThemeClass {
  static ThemeData darkTheme = ThemeData(
    primaryColor: myColor,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    datePickerTheme: DatePickerThemeData(headerBackgroundColor: myColor),
    cardColor: Color(0xff2B3038),
    canvasColor: Color(0xff20242A),
    cardTheme: CardTheme(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: myColor,
    ),
    appBarTheme: AppBarTheme(backgroundColor: Color(0xff2B3038)),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.white70),
      bodyLarge: TextStyle(color: Colors.white),
      labelLarge: TextStyle(color: myColor),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Color(0xff2B3038),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );

  //
  static ThemeData lightTheme = ThemeData(
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: myColor),
    cardTheme: CardTheme(
        elevation: 5,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.black),
      // bodyLarge: TextStyle(color: myColor),
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 248, 248, 248),
    cardColor: Colors.white,
    datePickerTheme: DatePickerThemeData(headerBackgroundColor: myColor),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
      iconTheme: IconThemeData(color: Colors.black),
    ),
  );
}

ThemeClass themeClass = ThemeClass();
