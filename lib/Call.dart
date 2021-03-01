import 'dart:async';

import 'package:flutter/material.dart';

class Call extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [CallTimer()],
      ),
    );
  }
}

class CallTimer extends StatefulWidget {
  int duration = 60;
  @override
  _CallTimerState createState() => _CallTimerState();
}

class _CallTimerState extends State<CallTimer> {
  Timer _timer;
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      widget.duration != 0
          ? setState(() => widget.duration--)
          : print("done with timer");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.duration.toString(),
      style: Theme.of(context).textTheme.headline3,
    );
  }
}
