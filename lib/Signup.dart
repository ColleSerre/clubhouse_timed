import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:http/http.dart' as http;

class LoginForm extends StatefulWidget {
  final bool onApple = Platform.isIOS; // display login with apple if true
  final bool warning;
  LoginForm({this.warning});
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<SnackBar> login() async {
    final user = await _googleSignIn.signIn();
    final googleAuth = await user.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      await auth.signInWithCredential(credential).then((userdata) {
        FirebaseDatabase.instance
            .reference()
            .child("Users")
            .child(userdata.user.uid)
            .set({
          "Sign-in date": DateTime.now().toString(),
          "DisplayName": userdata.user.displayName,
          "Email address": userdata.user.email,
          "Profile Pic": userdata.user.photoURL,
          "activated": true,
        });
      });
      Navigator.pushReplacementNamed(context, "/", arguments: user);
      return SnackBar(content: Text("Successfully logged in..."));
    } catch (e) {
      return SnackBar(content: Text(e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            GestureDetector(
              onTap: () async =>
                  ScaffoldMessenger.of(context).showSnackBar(await login()),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Image.asset("assets/google_icon.png"),
                    SizedBox(width: 10),
                    Text(
                      'Sign in with Google',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class SocialLogin extends StatefulWidget {
  bool loading = false;
  bool next = false;
  @override
  _SocialLoginState createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
  Future<bool> checkUsername(context, String method) async {
    final username = await prompt(
      context,
      title: Text(method),
      hintText: "Enter your Instagram username",
    );
    if (username != null) {
      setState(() => widget.loading = true);
      final response = await http.Client()
          .get(Uri.parse("https://www.instagram.com/$username"));
      if (response.statusCode == 404) {
        prompt(
          context,
          title: Text("User not found - Instagram"),
          hintText: "Enter a valid Instagram username",
        );
        setState(() => widget.loading = false);
        return false;
      } else {
        final user = FirebaseAuth.instance.currentUser;
        FirebaseDatabase.instance
            .reference()
            .child("Users")
            .child(user.uid)
            .update({"Instagram": username});
        setState(() {
          widget.loading = false;
          widget.next = true;
        });
        return true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor("#1B2431"),
      child: SafeArea(
        top: false,
        child: Center(
          child: Column(
            children: [
              widget.next
                  ? Container(
                      margin: const EdgeInsets.only(top: 25, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CupertinoButton(
                            child: Text("Next"),
                            onPressed: () =>
                                Navigator.pushReplacementNamed(context, "/"),
                          )
                        ],
                      ),
                    )
                  : Container(),
              Spacer(),
              Spacer(),
              Text(
                "Log into Social Media to keep track of the people you liked talking to...",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              widget.loading ? CircularProgressIndicator() : Container(),
              Spacer(),
              GestureDetector(
                onTap: () => checkUsername(context, "Instagram"),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16.0,
                  ),
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        HexColor("F58529"),
                        HexColor("DD2A7B"),
                        HexColor("515BD4"),
                      ],
                    ),
                    boxShadow: [BoxShadow(color: Colors.black, blurRadius: 10)],
                  ),
                  child: Center(child: Text("Instagram")),
                ),
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 16.0,
                ),
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black, blurRadius: 10)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.yellow,
                ),
                child: Center(
                  child:
                      Text("Snapchat", style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
