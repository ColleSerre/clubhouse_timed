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
      initialRoute: '/',
      routes: {
        '/': (context) => Scaffold(
              appBar: AppBar(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: IconButton(
                    icon: Icon(CupertinoIcons.person_crop_circle_badge_plus),
                    iconSize: 35,
                    color: Colors.black,
                    splashRadius: 25,
                    onPressed: () {},
                  ),
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
                        onPressed: () {}, //Navigator.push(notif view)
                        splashRadius: 20,
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
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: IconButton(
                      icon: CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/placeholder_image.jpg"),
                        backgroundColor: Colors.transparent,
                      ),
                      iconSize: 35,
                      splashRadius: 25,
                      onPressed: () {},
                    ),
                  )
                ],
                elevation: 0,
              ),
              body: Home(),
            ),
        '/Call': (context) => Scaffold(
              appBar: AppBar(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: IconButton(
                    icon: Icon(CupertinoIcons.person_crop_circle_badge_plus),
                    iconSize: 35,
                    color: Colors.black,
                    splashRadius: 25,
                    onPressed: () {},
                  ),
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
                        onPressed: () {}, //Navigator.push(notif view)
                        splashRadius: 20,
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
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: IconButton(
                      icon: CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/placeholder_image.jpg"),
                        backgroundColor: Colors.transparent,
                      ),
                      iconSize: 35,
                      splashRadius: 25,
                      onPressed: () {},
                    ),
                  )
                ],
                elevation: 0,
              ),
              body: Call(),
            ),
      },
    );
  }
}
