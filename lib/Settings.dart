import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class LoginForm extends StatefulWidget {
  final bool warning;
  LoginForm({this.warning});
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;
  void login() async {
    final user = await _googleSignIn.signIn();
    final googleAuth = await user.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await auth.signInWithCredential(credential);
    Navigator.popAndPushNamed(context, "/");
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "If you're seeing this, your account has been temporarily disabled or permanently deleted.... \n\nIf you feel like we've made a mistake, feel free to contact us on social media",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: GestureDetector(
                  onTap: () => login(),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15)),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Image.asset(
                            "assets/google_icon.png"), // <-- Use 'Image.asset(...)' here
                        SizedBox(width: 12),
                        Text(
                          'Sign in with Google',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InstagramLogin extends StatelessWidget {
  static const client_id = 151197196914082;
  List<String> uris = [];
  int count = 0;
  final url =
      "https://api.instagram.com/oauth/authorize?client_id=$client_id&redirect_uri=https://colleserre.github.io/InstagramAuthRedirectionURL/index.html&scope=user_profile&response_type=code";
  @override
  Widget build(BuildContext context) {
    // ignore: cancel_subscriptions
    final flutterWebviewPlugin = new FlutterWebviewPlugin();
    flutterWebviewPlugin.onUrlChanged.listen((event) async {
      uris.add(event);
      count++;
      print(count);
      if (count >= 3) {
        final client = http.Client();
        client.post(
          Uri.parse("https://api.instagram.com/oauth/access_token"),
          body: {
            "client_id": client_id.toString(),
            "client_secret": "",
            "grant_type": "authorization_code",
            "redirect_uri":
                "https://colleserre.github.io/InstagramAuthRedirectionURL/index.html",
            "code": Uri.parse(uris.last).queryParameters["code"],
          }, // SECRET REMOVE BEFORE COMMIT,
        ).then((response) {
          final json = jsonDecode(response.body);
          final accessToken = json["access_token"];
          final userID = json["user_id"];
          client
              .get(Uri.parse(
                  "https://graph.instagram.com/$userID?fields=username&access_token=$accessToken"))
              .then((profile) {
            final String username = jsonDecode(profile.body)["username"];
            FirebaseDatabase.instance
                .reference()
                .child("Users")
                .child(FirebaseAuth.instance.currentUser.uid)
                .child("Usernames")
                .update({"Instagram": username}).whenComplete(
              () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SuccessfulLogin(
                    username,
                  ),
                ),
              ),
            );
          });
        });
      }
    });
    return WebviewScaffold(
      url: url,
      appCacheEnabled: true,
    );
  }
}

class SuccessfulLogin extends StatelessWidget {
  String username = "";
  SuccessfulLogin(this.username);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(username),
      ),
    );
  }
}
