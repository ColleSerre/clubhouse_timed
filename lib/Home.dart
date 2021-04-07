import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:clubhouse_timed/Settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This class determines if user is logged in and redirects to Login or HaloButton

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
