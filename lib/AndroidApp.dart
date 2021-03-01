import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Home.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Call.dart';

class AndroidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: HexColor("#F0F0E4"),
        appBarTheme: AppBarTheme(
          backgroundColor: HexColor("#F0F0E4"),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.blueGrey[900],
        appBarTheme: AppBarTheme(backgroundColor: Colors.grey[900]),
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(CupertinoIcons.person_crop_circle_badge_plus),
            iconSize: 30,
            color: Colors.black,
            onPressed: () {},
          ),
          actions: [
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    CupertinoIcons.bell,
                    color: Colors.black,
                  ),
                  iconSize: 30,
                  onPressed: () {},
                ),
                Positioned(
                    bottom: 25,
                    left: 22,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text("1"),
                    ))
              ],
            ),
            IconButton(
              icon: CircleAvatar(
                backgroundColor: Colors.blue,
              ),
              iconSize: 30,
              onPressed: () {},
            )
          ],
          elevation: 0,
        ),
        body: Home(),
      ),
    );
  }
}
