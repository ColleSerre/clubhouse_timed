import 'package:clubhouse_timed/AndroidApp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//TODO: Implement Agora SDK

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.done
              ? AndroidApp()
              : MaterialApp(
                  home: Scaffold(
                    body: Center(
                      child: Text("Starting up (this shouldn't take long)..."),
                    ),
                  ),
                ),
    );
  }
}
