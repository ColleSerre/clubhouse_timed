import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  Widget content;
  App({this.content});

  @override
  _State createState() => _State();
}

class _State extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: IconButton(
            icon: Icon(
              CupertinoIcons.person_crop_circle_badge_plus,
              color: Colors.white,
            ),
            iconSize: 35,
            color: Colors.black,
            splashRadius: 25,
            onPressed: () {},
          ),
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(
                  CupertinoIcons.bell,
                ),
                iconSize: 30,
                onPressed: () {}, //Navigator.push(notif view)
                splashRadius: 20,
              ),
              Positioned(
                  bottom: 25,
                  left: 22,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text("1"),
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: IconButton(
              icon: CircleAvatar(
                backgroundImage: AssetImage("assets/placeholder_image.jpg"),
                backgroundColor: Colors.transparent,
              ),
              iconSize: 35,
              splashRadius: 25,
              onPressed: () {},
            ),
          )
        ],
        elevation: 0,
      ),
      body: widget.content,
    );
  }
}
