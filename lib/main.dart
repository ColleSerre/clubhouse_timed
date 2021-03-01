import 'package:clubhouse_timed/AndroidApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//TODO: Implement Agora SDK
//Inspiration and resources: https://www.youtube.com/watch?v=8YJqB4pNNgs ; https://mediasoup.org/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return AndroidApp();
  }
}
