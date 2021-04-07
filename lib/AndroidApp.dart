import 'package:clubhouse_timed/Home.dart';
import 'package:clubhouse_timed/Signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:clubhouse_timed/Call.dart';
import 'package:clubhouse_timed/Settings.dart';
import 'package:clubhouse_timed/Notifications.dart';

class AndroidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.red,
        textTheme: TextTheme(
          bodyText1: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          bodyText2: TextStyle(color: Colors.white, fontSize: 15),
          headline4: TextStyle(color: Colors.white),
        ),
        // scaffoldBackgroundColor: HexColor("#F0F0E4"),
        // scaffoldBackgroundColor: HexColor("#FDC1C5"),
        // scaffoldBackgroundColor: HexColor("FF7052"),
        // scaffoldBackgroundColor: HexColor("#1B2431"),
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/PreCallCountdown': (context) => PreCallCountdown(),
        '/Call': (context) => Call(),
        '/auth/instagram': (context) => InstagramLogin(),
        '/Notifs': (context) => Notifications(),
      },
    );
  }
}
