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
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    primary: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 17)),
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
    return SafeArea(
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
                  Text("Seconds Remainig", style: TextStyle(fontSize: 15)),
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
              child: SizedBox(
                width: dimensions.width / 1.3,
                height: dimensions.height / 1.5,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/placeholder_image.jpg"),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  width: MediaQuery.of(context).size.width / 2 - 25,
                  height: 50,
                  child: ElevatedButton(
                    child: Icon(
                      CupertinoIcons.phone_down_fill,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: Colors.red,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  width: MediaQuery.of(context).size.width / 2 - 25,
                  height: 50,
                  child: ElevatedButton(
                    child: Icon(
                      micOn ? CupertinoIcons.mic : CupertinoIcons.mic_off,
                    ),
                    onPressed: () {
                      setState(() => micOn = !micOn);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: micOn ? Colors.green : Colors.grey,
                    ),
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
