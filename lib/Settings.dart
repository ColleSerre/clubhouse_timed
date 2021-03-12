import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This class gets topics from our custom api and builds the children param for the SwitchForm class before building SwitchForm

class TopicList extends StatefulWidget {
  @override
  _TopicListState createState() => _TopicListState();

  Future<Map<dynamic, dynamic>> Function() getTopics = () async {
    final db = FirebaseDatabase.instance.reference().child("Topics");
    return (await db.once().then((value) => value.value));
  };
}

class _TopicListState extends State<TopicList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: Container(),
        actions: [
          CupertinoButton(
            child: Text("Done", style: TextStyle(fontSize: 18)),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: Future.wait([
            SharedPreferences.getInstance(),
            widget.getTopics(),
          ]),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Text("Something went wrong here...");
            } else if (snapshot.hasData) {
              SharedPreferences prefs = snapshot.data[0];
              Map<String, bool> topicPrefs = Map<String, bool>.from(
                jsonDecode(
                  prefs.getString("topicPrefs"),
                ),
              );
              return ListView(
                children: [
                  SwitchForm(
                    prefs: prefs,
                    children: [
                      for (var item in snapshot.data[1].entries)
                        item.value
                            ? ListSwitch(
                                title: item.key,
                                value: topicPrefs[item.key] == null
                                    ? false
                                    : topicPrefs[item.key],
                              )
                            : Container()
                    ],
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
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var listSwitch in widget.children) listSwitch,
        ],
      ),
    );
  }
}

// Code for individual tiles

class ListSwitch extends StatefulWidget {
  final title;
  bool value;
  ListSwitch({this.title, this.value = false});
  @override
  ListSwitchState createState() => ListSwitchState();
}

class ListSwitchState extends State<ListSwitch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.grey[800], borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Text(widget.title),
            Spacer(),
            Switch(
              value: widget.value,
              onChanged: (newVal) => setState(() => widget.value = newVal),
            )
          ],
        ),
      ),
    );
  }
}
