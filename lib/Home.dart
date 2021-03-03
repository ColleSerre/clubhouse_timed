import 'package:flutter/material.dart';
import 'MenuCards.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget divider = Divider(color: Colors.transparent, height: 15);
    return ListView(
      padding: const EdgeInsets.all(15.0),
      children: [
        AvatarCard(
          topic: "Politics",
        ),
        divider,
        AvatarCard(
          topic: "Gaming",
        ),
        divider,
        AvatarCard(
          topic: "Tech",
        ),
        divider,
        AvatarCard(
          topic: "Fashion",
        ),
        divider,
      ],
    );
  }
}
