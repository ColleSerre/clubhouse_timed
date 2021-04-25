import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Call extends StatefulWidget {
  @override
  _CallState createState() => _CallState();
}

class _CallState extends State<Call> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final flutterWebviewPlugin = new FlutterWebviewPlugin();
    flutterWebviewPlugin.onUrlChanged.listen((url) {
      if (url.endsWith("/end")) {
        flutterWebviewPlugin.dispose();
        Navigator.pop(context, false);
      }
    });
    final url =
        "https://tranquil-gorge-54186.herokuapp.com/?profile_pic=${user.photoURL}";
    print(url);
    return WebviewScaffold(url: url);
  }
}
