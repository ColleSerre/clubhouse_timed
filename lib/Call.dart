import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:timer_count_down/timer_count_down.dart';

// This widget is supposed to be played before the call but the idea is being discussed for we aren't sure of its importance
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
                ? Text(time.toInt().toString(), style: TextStyle(fontSize: 45))
                : Text("Start Chatting !", style: TextStyle(fontSize: 35)),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
                style: ElevatedButton.styleFrom(
                    elevation: 10,
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
    return Scaffold(
      backgroundColor: HexColor("#e4dbce"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                      Text("Seconds Remaining",
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                    ],
                  ),
                  onFinished: () {},
                ),
                Spacer(),
                Transform.scale(
                  scale: 7.5,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: talking ? Colors.green : Colors.transparent,
                        width: 0.5,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/placeholder_image.jpg"),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => micOn = !micOn),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            micOn
                                ? "🔊 Toggle mic (currently on)"
                                : "🤐 Toggle mic (currently off)",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.emoji_emotions_outlined,
                              color: Colors.white),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context, false),
                          child: Container(
                            margin: const EdgeInsets.only(left: 8.0),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "👋 Leave call",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
