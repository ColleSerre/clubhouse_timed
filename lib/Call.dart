import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';

class PreCallCountdown extends StatefulWidget {
  @override
  _PreCallCountdownState createState() => _PreCallCountdownState();
}

class _PreCallCountdownState extends State<PreCallCountdown> {
  @override
  Widget build(BuildContext context) {
    return Countdown(
      seconds: 5,
      build: (BuildContext context, double time) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            time != 0
                ? Text(time.toInt().toString(), style: TextStyle(fontSize: 60))
                : Text("Start Chatting !", style: TextStyle(fontSize: 45)),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/");
                },
                child: Text("Cancel"),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    primary: Colors.red,
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, top: 12, bottom: 12)),
              ),
            )
          ],
        ),
      ),
      onFinished: () => Navigator.popAndPushNamed(context, "/Call"),
    );
  }
}

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
      padding:
          const EdgeInsets.only(bottom: 40.0, left: 20, right: 20, top: 10),
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
            Spacer(flex: 1),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: talking ? Colors.green : Colors.transparent,
                    width: 4),
                shape: BoxShape.circle,
              ),
              child: SizedBox(
                width: dimensions.width / 1.3,
                height: dimensions.height / 1.5,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/placeholder_image.jpg"),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
            Spacer(flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
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
                Spacer(),
                Container(
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
