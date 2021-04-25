import 'package:clubhouse_timed/AndroidApp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

/* 
TODO:

* Implement Snapchat sign-in (https://github.com/sukhkmr19/flutter_snapchat)
* Rework sign-in flow
  * Remove Twitter login
  * Label screens
* Create end of call screen
* Prepare Android version
* Publish 🎉

*/
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
                  debugShowCheckedModeBanner: false,
                  home: Scaffold(
                    backgroundColor: HexColor("1e1e1e"),
                    body: Center(
                      child: Text(
                        "Initializing app... (this shouldn't take long)",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
    );
  }
}
