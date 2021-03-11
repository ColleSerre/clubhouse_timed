import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TopicList extends StatefulWidget {
  // This class gets topics from our custom api and builds the children param for the SwitchForm class before building SwitchForm
  final url = Uri.parse("http://localhost:8080");
  final getPreferences = () async => await SharedPreferences.getInstance();
  @override
  _TopicListState createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.wait(
            [http.get(widget.url), SharedPreferences.getInstance()]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> subtopics = jsonDecode(snapshot.data[0].body);
            SharedPreferences prefs = snapshot.data[1];
            Map<String, bool> topicPrefs = Map<String, bool>.from(
                jsonDecode(prefs.getString("topicPrefs")));
            return SwitchForm(
              prefs: prefs,
              children: [
                for (var item in subtopics.keys)
                  ListSwitch(
                    title: item,
                    value: topicPrefs[item],
                  )
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

class SwitchForm extends StatefulWidget {
  // Takes children as param and builds each child
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
      tempPreferences[item.title] = item.value;
    }
    SharedPreferences prefs = widget.prefs;
    prefs.setString('topicPrefs', jsonEncode(tempPreferences));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var listSwitch in widget.children) listSwitch,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoButton(
                child: Text("Done"),
                color: Colors.blue,
                onPressed: () {
                  Navigator.pop(context);
                }),
          )
        ],
      ),
    );
  }
}

class ListSwitch extends StatefulWidget {
  // Code for individual tiles
  final title;
  bool value;
  ListSwitch({this.title, this.value});
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
