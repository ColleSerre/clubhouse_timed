<<<<<<< HEAD
<<<<<<< HEAD
import 'package:firebase_database/firebase_database.dart';
<<<<<<< HEAD
import 'package:clubhouse_timed/Settings.dart';
=======
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:clubhouse_timed/Signup.dart';
import 'package:hexcolor/hexcolor.dart';
>>>>>>> parent of e776479... Merge branch 'master' of https://github.com/ColleSerre/clubhouse_timed
=======
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
>>>>>>> parent of fe1c52c... syncing macbook changes
=======
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:clubhouse_timed/Signup.dart';
import 'package:hexcolor/hexcolor.dart';
>>>>>>> parent of e776479... Merge branch 'master' of https://github.com/ColleSerre/clubhouse_timed
import 'package:shared_preferences/shared_preferences.dart';

// This class determines if user is logged in and redirects to Login or HaloButton

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      body: StreamBuilder(
          stream: auth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error));
            } else if (snapshot.connectionState == ConnectionState.active) {
              try {
                snapshot.data.reload();
              } catch (e) {
                debugPrint("User is not logged in");
              }
              if (snapshot.data == null) {
                return LoginForm();
              } else {
                return FutureBuilder(
                    future: FirebaseDatabase.instance
                        .reference()
                        .child("Users")
                        .child(snapshot.data.uid)
                        .once(),
                    builder: (context, dbSnapshot) {
                      if (dbSnapshot.connectionState == ConnectionState.done) {
                        Map userData = dbSnapshot.data.value;
                        return userData["Instagram"] == false &&
                                userData["Snapchat"] == false
                            ? SocialLogin()
                            : HaloButton();
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    });
              }
            } else {
<<<<<<< HEAD
              return HaloButton();
=======
              return Container();
>>>>>>> parent of e776479... Merge branch 'master' of https://github.com/ColleSerre/clubhouse_timed
            }
          }),
    );
  }
}

// Shows if user isn't logged in

class LoginForm extends StatefulWidget {
  final bool warning;
  LoginForm({this.warning});
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;
  void login() async {
    final user = await _googleSignIn.signIn();
    final googleAuth = await user.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await auth.signInWithCredential(credential);
    Navigator.popAndPushNamed(context, "/");
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "If you're seeing this, your account has been temporarily disabled or permanently deleted.... \n\nIf you feel like we've made a mistake, feel free to contact us on social media",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15)),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Image.asset(
                          "assets/google_icon.png"), // <-- Use 'Image.asset(...)' here
                      SizedBox(width: 12),
                      Text(
                        'Sign in with Google',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Main Menu View

class HaloButton extends StatefulWidget {
  Future<Map<dynamic, dynamic>> getTopics() async {
    final db = FirebaseDatabase.instance.reference().child("Topics");
    return (await db.once().then((value) => value.value));
  }

  List validate(topicMap) {
    List validatedTopicList = [];
    for (var item in topicMap.entries) {
      if (item.value) {
        validatedTopicList.add(item.key);
      }
    }
    return validatedTopicList;
  }

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
    return Scaffold(
      drawer: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Drawer(
          child: Container(
            child: ListView(
              children: [
                ListTile(
                  title: Text("Username", style: TextStyle(fontSize: 20)),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/placeholder_image.jpg"),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text("Notifications", style: TextStyle(fontSize: 18)),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 4.0, bottom: 3.0),
                    child: Icon(Icons.notifications_none_sharp, size: 30),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    child: Text(
                      "1",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                ListTile(
                  title: Text("Conversation Topics",
                      style: TextStyle(fontSize: 18)),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 7.5, bottom: 3.0),
                    child: Icon(Icons.messenger_sharp),
                  ),
                  onTap: () => Navigator.popAndPushNamed(context, "/TopicList"),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
          future: Future.wait(
              [SharedPreferences.getInstance(), widget.getTopics()]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
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
                            boxShadow: [
                              BoxShadow(color: Colors.white60, blurRadius: 15)
                            ]),
                        child: ElevatedButton(
                            onPressed: () {
                              print(widget.validate(snapshot.data[1]));
                              Navigator.pushNamed(context, "/PreCallCountdown");
                            },
                            child: Icon(
                              Icons.power_settings_new_sharp,
                              color: Colors.black,
                              size: 45,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
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
