import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:clubhouse_timed/Settings.dart';
import 'package:hexcolor/hexcolor.dart';

// This class determines if user is logged in and redirects to Login or HaloButton

class Init extends StatelessWidget {
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return StreamBuilder(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error));
        } else if (snapshot.connectionState == ConnectionState.active) {
          try {
            snapshot.data.reload();
          } catch (e) {
            print(e);
          }
          if (snapshot.data == null) {
            return InitialSignUpFlow();
          } else if (snapshot.data != null) {
            return FutureBuilder(
              future: FirebaseDatabase.instance
                  .reference()
                  .child("Users")
                  .child(auth.currentUser.uid)
                  .once(),
              builder: (context, unameSnapshot) {
                if (unameSnapshot.hasData) {
                  return unameSnapshot.data.value["Instagram"] == false &&
                          unameSnapshot.data.value["Snapchat"] == false
                      ? InitialSignUpFlow()
                      : Home();
                } else if (unameSnapshot.hasError) {
                  return Center(
                    child: Text(unameSnapshot.error.toString()),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else {
            return Home();
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

// Main Menu View

class HaloButton extends StatefulWidget {
  bool clicked = false;
  @override
  HaloButtonState createState() => HaloButtonState();
}

class HaloButtonState extends State<HaloButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  int selected = 0;
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1300),
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
      duration: Duration(milliseconds: 700),
      curve: Curves.decelerate,
      color: widget.clicked ? HexColor("#EAE7DD") : HexColor("1e1e1e"),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: animation,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.white60, blurRadius: 15)],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Future.delayed(Duration(milliseconds: 500)).then(
                      (value) => Navigator.pushNamed(context, '/call').then(
                        (value) => setState(() => widget.clicked = value),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.power_settings_new_sharp,
                    color: Colors.black,
                    size: 45,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: CircleBorder(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: HaloButton(),
    );
  }
}
