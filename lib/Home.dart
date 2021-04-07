import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:clubhouse_timed/Settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

// This class determines if user is logged in and redirects to LoginForm or HaloButton

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    bool additionalInfo = true;
    return StreamBuilder(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error));
          } else if (snapshot.connectionState == ConnectionState.active) {
            try {
              snapshot.data.reload();
            } catch (e) {
              additionalInfo = true;
            }
            if (snapshot.data == null) {
              return LoginForm(warning: additionalInfo);
            } else {
              return InstagramLogin(); // Changed before commmit
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

// Main Menu View

class HaloButton extends StatefulWidget {
  @override
  HaloButtonState createState() => HaloButtonState();
}

class HaloButtonState extends State<HaloButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  ColorTween colorTween;
  bool clicked;
  void initState() {
    super.initState();
    clicked = false;
    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
      value: 1.0,
      lowerBound: 0.87,
      upperBound: 0.98,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.repeat(reverse: true);
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 2000),
      curve: Curves.fastLinearToSlowEaseIn,
      color: clicked ? HexColor("#e4dbce") : HexColor("#1B2431"),
      child: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ScaleTransition(
                      scale: animation,
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  clicked ? Colors.white : HexColor("#1E488F"),
                              blurRadius: 40,
                            )
                          ],
                        ),
                        child: ElevatedButton(
                            onPressed: () async {
                              setState(() => clicked = true);
                              print(snapshot.data[0]);
                              Future.delayed(Duration(milliseconds: 600))
                                  .then((value) {
                                Navigator.pushNamed(context, "/Call").then(
                                    (value) => setState(() => clicked = false));
                              });
                            },
                            child: Icon(
                              CupertinoIcons.power,
                              size: 45,
                              color: clicked ? Colors.black : Colors.white,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary:
                                  clicked ? Colors.white : HexColor("#016795"),
                              shape: CircleBorder(),
                            )),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
