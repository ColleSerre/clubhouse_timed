import 'dart:math';
import 'package:flutter/material.dart';

// Version with title + description without CircleAvatar (more or less deprecated at this point)
class RoomCard extends StatelessWidget {
  final MaterialColor color;
  final String description;
  final String username;
  RoomCard({this.color, this.description, this.username});
  @override
  Widget build(BuildContext context) {
    final Size dimensions = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: color[500],
        borderRadius: BorderRadius.circular(15),
      ),
      child: SizedBox(
        width: dimensions.width,
        height: dimensions.height / 4.3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 0),
                child: Row(
                  children: [
                    Text(
                      "$username",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(
                        "assets/placeholder_image.jpg",
                      ),
                      radius: 25.0,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      child: Text(
                        "$description",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[900],
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {},
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
    );
  }
}

// Version with CircleAvatar only (more original, a lot less like Clubhouse)
class AvatarCard extends StatelessWidget {
  final List<Widget> avatarArr = [
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
  final String topic;
  final Random random = new Random();
  AvatarCard({this.topic});
  @override
  Widget build(BuildContext context) {
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
