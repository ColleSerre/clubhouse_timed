import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clubhouse_timed/MenuCards.dart';

// This class gets topics from our custom api and builds the children param for the SwitchForm class before building SwitchForm

class TopicList extends StatefulWidget {
  @override
  _TopicListState createState() => _TopicListState();

  final Future<Map<dynamic, dynamic>> Function() getTopics = () async {
    final db = FirebaseDatabase.instance.reference().child("Topics");
    return (await db.once().then((value) => value.value));
  };
}

class _TopicListState extends State<TopicList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: Future.wait([
          SharedPreferences.getInstance(),
          widget.getTopics(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Text(
                "Smells like rotten bugs, has something gone wrong here ? 🐞 🤔");
          } else if (snapshot.hasData) {
            SharedPreferences prefs = snapshot.data[0];
            final temp = prefs.getString("topicPrefs") == null
                ? {}
                : prefs.getString("topicPrefs");
            Map<String, bool> topicPrefs = Map<String, bool>.from(
              jsonDecode(temp.toString()),
            );
            final sortedKeys = List.from(snapshot.data[1].keys);
            sortedKeys.sort();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: RoomCard(
                    color: Colors.blue,
                    username: "Username",
                    description: "Lorem Ipsum Dolor Sit Amet",
                  ),
                ),
                Expanded(
                  child: SwitchForm(
                    prefs: prefs,
                    children: [
                      for (var item in sortedKeys)
                        snapshot.data[1][item]
                            ? ListSwitch(
                                title: item,
                                value: topicPrefs[item] == null
                                    ? false
                                    : topicPrefs[item],
                              )
                            : Container()
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

// Takes children as param and builds each child

class SwitchForm extends StatefulWidget {
  final children;
  final prefs;
  SwitchForm({this.children, this.prefs});
  @override
  SwitchFormState createState() => SwitchFormState();
}

class SwitchFormState extends State<SwitchForm> {
  void dispose() {
    super.dispose();
    Map<String, bool> tempPreferences = {};
    for (var item in widget.children) {
      try {
        tempPreferences[item.title] = item.value;
      } catch (e) {
        print("A Container placeholding for a disabled subject was found");
      }
    }
    SharedPreferences prefs = widget.prefs;
    prefs.setString('topicPrefs', jsonEncode(tempPreferences));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        children: [for (var item in widget.children) item],
      ),
    );
  }
}

<<<<<<< HEAD
class SuccessfulLogin extends StatelessWidget {
  String username = "";
  SuccessfulLogin(this.username);
=======
// Code for individual tiles

// ignore: must_be_immutable
class ListSwitch extends StatefulWidget {
  final title;
  bool value;
  ListSwitch({this.title, this.value = false});
  @override
  ListSwitchState createState() => ListSwitchState();
}

class ListSwitchState extends State<ListSwitch> {
>>>>>>> parent of e776479... Merge branch 'master' of https://github.com/ColleSerre/clubhouse_timed
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.grey[900], borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17),
            ),
          ),
          Expanded(
            child: Transform.scale(
              scale: 1.5,
              child: CupertinoSwitch(
                value: widget.value,
                activeColor: Colors.blue,
                onChanged: (newVal) => setState(() => widget.value = newVal),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
