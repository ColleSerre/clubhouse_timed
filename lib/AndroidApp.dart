import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Home.dart';
import 'Call.dart';
import 'package:clubhouse_timed/commons.dart';
import 'package:clubhouse_timed/Settings.dart';

class AndroidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
            bodyText1: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(color: Colors.white, fontSize: 15),
            headline4: TextStyle(color: Colors.white)),
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.grey[900],
        //scaffoldBackgroundColor: HexColor("#F0F0E4"),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => App(content: Home()),
        '/PreCallCountdown': (context) => App(content: PreCallCountdown()),
        '/Call': (context) => App(content: Call()),
        '/TopicList': (context) => TopicList(),
      },
    );
  }
}
