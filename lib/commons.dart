import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  final Widget content;
  final bool doneButton;
  App({this.content, this.doneButton = false});

  @override
  _State createState() => _State();
}

class _State extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: Container(),
        actions: widget.doneButton
            ? [
                CupertinoButton(
                  child: Text("Done", style: TextStyle(fontSize: 18)),
                  onPressed: () => Navigator.pop(context),
                )
              ]
            : [Container()],
      ),
      body: widget.content,
    );
  }
}
