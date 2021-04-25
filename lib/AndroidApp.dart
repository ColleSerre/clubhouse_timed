import 'package:clubhouse_timed/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:clubhouse_timed/Call.dart';
import 'package:clubhouse_timed/Settings.dart';

class AndroidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
            bodyText1: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(color: Colors.white, fontSize: 15),
            headline4: TextStyle(color: Colors.white)),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.transparent,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Init(),
        '/auth/instagram': (context) => InstagramLoginView(),
        '/login': (context) => InitialSignUpFlow(),
        '/call': (context) => Call(),
      },
    );
  }
}
