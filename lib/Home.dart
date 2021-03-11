import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final url = Uri.parse("http://localhost:8080");
    return FutureBuilder(
        future: http.get(url),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.done
                ? Center(child: HaloButton())
                : Center(child: CircularProgressIndicator()));
  }
}

class HaloButton extends StatefulWidget {
  @override
  HaloButtonState createState() => HaloButtonState();
}

class HaloButtonState extends State<HaloButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
      value: 1.0,
      lowerBound: 0.87,
      upperBound: 0.98,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.repeat(reverse: true);
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ScaleTransition(
                      scale: animation,
                      child: Container(
                        height: 170,
                        width: 170,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: Colors.white60, blurRadius: 15)
                            ]),
                        child: ElevatedButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, "/Call"),
                            child: Icon(
                              Icons.power_settings_new_sharp,
                              color: Colors.black,
                              size: 45,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: CircleBorder(),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 40,
                            ),
                            splashRadius: 1,
                            onPressed: () =>
                                Navigator.pushNamed(context, "/TopicList"))
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
