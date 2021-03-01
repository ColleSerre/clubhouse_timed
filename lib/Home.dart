import 'package:flutter/material.dart';
import 'MenuCards.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size dimensions = MediaQuery.of(context).size;
    return ListView(
      padding: const EdgeInsets.all(15.0),
      children: [
        AvatarCard(
          dimensions: dimensions,
          color: Colors.deepOrange,
          topic: "Politics",
        ),
        Divider(),
        AvatarCard(
          dimensions: dimensions,
          color: Colors.red,
          topic: "Gaming",
        ),
        Divider(),
        AvatarCard(
          dimensions: dimensions,
          color: Colors.blue,
          topic: "Tech",
        ),
        Divider(),
        AvatarCard(
          dimensions: dimensions,
          color: Colors.green,
          topic: "Fashion",
        ),
        Divider()
      ],
    );
  }
}
