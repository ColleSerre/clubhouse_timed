import 'dart:math';
import 'package:flutter/material.dart';

// Version with title + description without CircleAvatar
class RoomCard extends StatelessWidget {
  final Size dimensions;
  final MaterialColor color;
  RoomCard({this.dimensions, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: dimensions.width,
        height: dimensions.height / 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: [
                    Text(
                      "Dev Talk",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: color[800],
                      radius: 25.0,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  "A room where we talk about stuff related to software dev.",
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Meet Someone"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        primary: color[600],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AvatarCard extends StatelessWidget {
  final Size dimensions;
  final MaterialColor color;
  List<Widget> avatarArr;
  final String topic;
  final Random random = new Random();
  AvatarCard({this.dimensions, this.color, this.topic});
  @override
  Widget build(BuildContext context) {
    avatarArr = [
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
      CircleAvatar(
        backgroundColor: color[400],
      ),
    ];
    avatarArr.length = random.nextInt(2) == 1.0
        ? dimensions.width ~/ 25
        : dimensions.width ~/
            26; // TODO: change placeholder values (15 and 16) to adapt to device dimensions
    return Container(
      decoration: BoxDecoration(
        color: color[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: dimensions.width,
        height: dimensions.height / 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 4.0),
                child: Text(
                  topic,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                  child: Wrap(
                spacing: 4.0,
                runSpacing: 4.0,
                children: avatarArr,
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Start", style: TextStyle(fontSize: 17)),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        primary: color[500],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
