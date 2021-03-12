import 'package:clubhouse_timed/AndroidApp.dart';
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
    return AndroidApp();
  }
}
