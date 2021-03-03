import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';

class Call extends StatefulWidget {
  @override
  _CallState createState() => _CallState();
}

class _CallState extends State<Call> {
  bool talking = true;
  bool micOn = true;
  @override
  Widget build(BuildContext context) {
    Size dimensions = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Countdown(
              seconds: 120,
              build: (BuildContext context, double time) => Column(
                children: [
                  Text(
                    time.toInt().toString(),
                    style: TextStyle(fontSize: 30),
                  ),
                  Text("Seconds Remaining", style: TextStyle(fontSize: 15)),
                ],
              ),
              onFinished: () {},
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: talking ? Colors.green : Colors.transparent,
                    width: 4),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/placeholder_image.jpg"),
                backgroundColor: Colors.transparent,
                radius: dimensions.width / 2.7,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  decoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: IconButton(
                        splashRadius: 35,
                        iconSize: 30,
                        color: Colors.white,
                        icon: Icon(
                          CupertinoIcons.phone_down_fill,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  decoration: BoxDecoration(
                      color: micOn ? Colors.green : Colors.grey,
                      shape: BoxShape.circle),
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: IconButton(
                        splashRadius: 35,
                        iconSize: 30,
                        color: Colors.white,
                        icon: Icon(
                          micOn ? Icons.mic : Icons.mic_off,
                        ),
                        onPressed: () => setState(() => micOn = !micOn)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
