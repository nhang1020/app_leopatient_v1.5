import 'package:app/src/utils/variables.dart';
import 'package:app/src/utils/theme.dart';
import 'package:app/src/views/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.indexTheme, this.indexColor});
  final indexTheme;
  final indexColor;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var brightness;
  @override
  void initState() {
    super.initState();
    brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(widget.indexTheme, widget.indexColor),
      builder: (context, child) {
        final themeProvider = Provider.of<ThemeProvider>(context);

        if (themeProvider.themeMode == ThemeMode.system &&
            brightness != MediaQuery.of(context).platformBrightness) {
          brightness = MediaQuery.of(context).platformBrightness;
          themeProvider.toggleColor(themeProvider.indexCl, context: context);
        }
        return MaterialApp(
          navigatorKey: MyApp.navigatorKey,
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale('vi', 'VN')],
          darkTheme: ThemeData(
            chipTheme: ChipThemeData(backgroundColor: Colors.transparent),
            primaryColorDark: myColor,
            brightness: Brightness.dark,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            datePickerTheme: DatePickerThemeData(
                headerBackgroundColor: myColor,
                headerForegroundColor: Color(0xff20242A)),
            cardColor: Color(0xff2B3038),
            canvasColor: Color(0xff20242A),
            cardTheme: CardTheme(
              // elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              shadowColor: Colors.black26,
            ),
            colorScheme: ColorScheme.dark(
              primary: myColor,
            ),
            bannerTheme: MaterialBannerThemeData(shadowColor: Colors.black38),
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
          ),
          theme: ThemeData(
            bannerTheme: MaterialBannerThemeData(
                shadowColor: Colors.black.withOpacity(.1)),
            chipTheme: ChipThemeData(backgroundColor: Colors.transparent),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: myColor),
            cardTheme: CardTheme(
                elevation: 5,
                shadowColor: Colors.black12,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            textTheme: TextTheme(
              bodyMedium: TextStyle(color: Colors.black),
              // bodyLarge: TextStyle(color: primaryColor),
              displayLarge: TextStyle(color: Colors.black54),
            ),
            scaffoldBackgroundColor: const Color.fromARGB(255, 248, 248, 248),
            cardColor: Colors.white,
            canvasColor: const Color.fromARGB(255, 245, 247, 248),
            searchViewTheme: SearchViewThemeData(elevation: 1),
            datePickerTheme: DatePickerThemeData(
              headerBackgroundColor: myColor,
            ),
            appBarTheme: AppBarTheme(
              color: Colors.white,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
              iconTheme: IconThemeData(color: Colors.black),
            ),
            // useMaterial3: true,
          ),
          home: SplashScreenLoader(),
        );
      });
}
