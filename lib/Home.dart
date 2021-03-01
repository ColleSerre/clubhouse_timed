import 'package:flutter/material.dart';
import 'MenuCards.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget divider = Divider(color: Colors.transparent, height: 15);
    Size dimensions = MediaQuery.of(context).size;
    return ListView(
      padding: const EdgeInsets.all(15.0),
      children: [
        AvatarCard(
          dimensions: dimensions,
          color: Colors.deepOrange,
          topic: "Politics",
        ),
        divider,
        AvatarCard(
          dimensions: dimensions,
          color: Colors.red,
          topic: "Gaming",
        ),
        divider,
        AvatarCard(
          dimensions: dimensions,
          color: Colors.blue,
          topic: "Tech",
        ),
        divider,
        AvatarCard(
          dimensions: dimensions,
          color: Colors.green,
          topic: "Fashion",
        ),
        divider,
      ],
    );
  }
}
