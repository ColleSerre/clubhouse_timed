import 'dart:math';
import 'package:flutter/material.dart';

// Version with title + description without CircleAvatar (more or less deprecated at this point)
class RoomCard extends StatelessWidget {
  final MaterialColor color;
  RoomCard({this.color});
  @override
  Widget build(BuildContext context) {
    final Size dimensions = MediaQuery.of(context).size;
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

// Version with CircleAvatar only (more original, a lot less like Clubhouse)
class AvatarCard extends StatelessWidget {
  List<Widget> avatarArr;
  final String topic;
  final Random random = new Random();
  AvatarCard({this.topic});
  @override
  Widget build(BuildContext context) {
    avatarArr = [
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/placeholder_image.jpg"),
        backgroundColor: Colors.transparent,
      ),
    ];
    // TODO: change placeholder values (15 and 16) to adapt to device dimensions
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 270,
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
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    fontFamily: "SanFrancisco",
                  ),
                ),
              ),
              Expanded(
                  child: Wrap(
                spacing: 7.0,
                runSpacing: 4.0,
                children: avatarArr,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
