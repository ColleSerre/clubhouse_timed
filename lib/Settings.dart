import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_brand_icons/flutter_brand_icons.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class InitialSignUpFlow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    final deviceDimensions = MediaQuery.of(context).size;
    return Container(
      color: Colors.grey[900],
      child: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 20.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 20),
                      width: deviceDimensions.width / 1.3,
                      child: GoogleSignInButton(),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 25),
                      width: deviceDimensions.width / 1.3,
                      child: TwitterSignInButton(),
                    ),
                    Platform.isIOS
                        ? Container(
                            padding: const EdgeInsets.only(bottom: 25),
                            width: deviceDimensions.width / 1.3,
                            child: AppleSignInButton(),
                          )
                        : Container(),
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      width: deviceDimensions.width / 1.3,
                      child: EmailSignInButton(),
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

// A button styled accordingly to Google's design rules, on click it starts the sign-in flow

class GoogleSignInButton extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

  void googleLogin() async {
    final user = await _googleSignIn.signIn();
    final googleAuth = await user.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await auth.signInWithCredential(credential);
    await FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(auth.currentUser.uid)
        .set({
      "Display name": auth.currentUser.displayName,
      "Email address": auth.currentUser.email,
      "Profile pic": auth.currentUser.photoURL,
      "Sign-in date": DateTime.now().toString(),
      "Usernames": {
        "Instagram": false,
        "Snapchat": false,
        "Twitter": false,
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => googleLogin(),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.blue[700],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(
              "assets/Google_icon.png",
              height: 30,
            ),
            Spacer(),
            Text(
              "Sign-In with Google",
              style: TextStyle(
                fontSize: 17.5,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class TwitterSignInButton extends StatelessWidget {
  void loginWithTwitter(context) async {
    //apiKey: "HStEsIpcDg64QiXUdCh7OF1OW",
    //apiSecretKey: "4nFPsOvvNCmjvuNjNNCyQ1raZpOXExM6TyqKeET9XyDWavDXr8",
    //bearerToken: AAAAAAAAAAAAAAAAAAAAAFDROQEAAAAAnQzAQbzwEz7zFmwRFBoE4PXXLxc%3DH9ETuTNKj4cXoXFcPHTl90J9laptjgHEEJAFT3lO1A7z5V5wjb,
    final twitterLogin = TwitterLogin(
      consumerKey: "HStEsIpcDg64QiXUdCh7OF1OW",
      consumerSecret: "4nFPsOvvNCmjvuNjNNCyQ1raZpOXExM6TyqKeET9XyDWavDXr8",
    );

    final TwitterLoginResult loginResult = await twitterLogin.authorize();
    final TwitterSession twitterSession = loginResult.session;
    // Create a credential from the access token
    final AuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: twitterSession.token, secret: twitterSession.secret);

    // Once signed in, return the UserCredential
    final auth = FirebaseAuth.instance;
    await auth.signInWithCredential(twitterAuthCredential);
    await FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(auth.currentUser.uid)
        .set({
      "Display name": auth.currentUser.displayName,
      "Email address": auth.currentUser.email,
      "Profile pic": auth.currentUser.photoURL,
      "Sign-in date": DateTime.now().toString(),
      "Usernames": {
        "Instagram": false,
        "Snapchat": false,
        "Twitter": loginResult.session.username,
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => loginWithTwitter(context),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        child: Row(
          children: [
            Icon(
              BrandIcons.twitter,
              size: 30,
            ),
            Spacer(),
            Text(
              "Sign-In with Twitter",
              style: TextStyle(
                fontSize: 17.5,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class EmailSignInButton extends StatefulWidget {
  @override
  _EmailSignInButtonState createState() => _EmailSignInButtonState();
}

class _EmailSignInButtonState extends State<EmailSignInButton> {
  bool loginTriggered = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => loginTriggered = true),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.email, size: 30),
                Spacer(),
                Text(
                  "Create an account",
                  style: TextStyle(
                    fontSize: 17.5,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        loginTriggered
            ? Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(17.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                      spreadRadius: 5,
                    )
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    TextField(
                      autocorrect: false,
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      autocorrect: false,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);
                          await userCredential.user.sendEmailVerification();
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text("The provided password is too weak."),
                              ),
                            );
                          } else if (e.code == 'email-already-in-use') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "An account already exists for that email."),
                              ),
                            );
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text(
                        "Create account",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    )
                  ],
                ))
            : Container()
      ],
    );
  }
}

// TODO: Implement Sign-In with Apple (we need to buy the $100 Apple dev program license)

class AppleSignInButton extends StatelessWidget {
  appleLogin() {
    /// Generates a cryptographically secure random nonce, to be included in a
    /// credential request.
    String generateNonce([int length = 32]) {
      final charset =
          '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
      final random = Random.secure();
      return List.generate(
          length, (_) => charset[random.nextInt(charset.length)]).join();
    }

    /// Returns the sha256 hash of [input] in hex notation.
    String sha256ofString(String input) {
      final bytes = utf8.encode(input);
      final digest = sha256.convert(bytes);
      return digest.toString();
    }

    Future<UserCredential> signInWithApple() async {
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => appleLogin(),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        child: Row(
          children: [
            Icon(
              BrandIcons.apple,
              size: 25,
            ),
            Spacer(),
            Text(
              "Sign-In with Apple",
              style: TextStyle(
                fontSize: 17.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class InstagramSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InstagramLoginView(
            initialLogin: true,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            HexColor("F58529"),
            HexColor("DD2A7B"),
            HexColor("515BD4"),
          ]),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              BrandIcons.instagram,
              size: 30,
            ),
            Spacer(),
            Text(
              "Sign-In with Instagram",
              style: TextStyle(
                fontSize: 17.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

// Returns a webview to log the user in with Instagram

class InstagramLoginView extends StatefulWidget {
  bool initialLogin = false;
  String url = "";
  InstagramLoginView({this.initialLogin});
  static const client_id = 151197196914082;

  @override
  _InstagramLoginViewState createState() => _InstagramLoginViewState();
}

class _InstagramLoginViewState extends State<InstagramLoginView> {
  final prompt =
      "https://api.instagram.com/oauth/authorize?client_id=${InstagramLoginView.client_id}&redirect_uri=https://colleserre.github.io/InstagramAuthRedirectionURL/index.html&scope=user_profile&response_type=code";

  @override
  Widget build(BuildContext context) {
    // ignore: cancel_subscriptions
    final flutterWebviewPlugin = new FlutterWebviewPlugin();
    flutterWebviewPlugin.onUrlChanged.listen((url) async {
      if (url.startsWith(
        "https://colleserre.github.io/InstagramAuthRedirectionURL/index.html",
      )) {
        getUserData(flutterWebviewPlugin);
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: WebviewScaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ButtonBar(
              children: [
                IconButton(
                  icon: Icon(
                    CupertinoIcons.xmark_circle,
                    size: 35,
                    color: Colors.black,
                  ),
                  onPressed: () => flutterWebviewPlugin.close().then(
                        (value) => Navigator.pop(context),
                      ),
                )
              ],
            ),
          ),
          url: prompt,
        ),
      ),
    );
  }

  Future<String> getUserData(FlutterWebviewPlugin flutterWebviewPlugin) async {
    flutterWebviewPlugin.close();
    final client = http.Client();
    final response = await client.post(
      Uri.parse("https://api.instagram.com/oauth/access_token"),
      body: {
        "client_id": InstagramLoginView.client_id.toString(),
        "client_secret": "4c90f7db7c8d7460831451d48085b4eb",
        "grant_type": "authorization_code",
        "redirect_uri":
            "https://colleserre.github.io/InstagramAuthRedirectionURL/index.html",
        "code": Uri.parse(widget.url).queryParameters["code"],
      }, // SECRET REMOVE BEFORE COMMIT,
    );
    final json = jsonDecode(response.body);
    final String accessToken = json["access_token"];
    final String userID = json["user_id"].toString();
    final profile = await client.get(
      Uri.parse(
          "https://graph.instagram.com/$userID?fields=username,id&access_token=$accessToken"),
    );
    final userJson = jsonDecode(profile.body);
    final String username = userJson["username"];
    if (widget.initialLogin == false)
      FirebaseDatabase.instance
          .reference()
          .child("Users")
          .child(FirebaseAuth.instance.currentUser.uid)
          .child("Usernames")
          .update({"Instagram": username}).whenComplete(
        () => Navigator.pushReplacementNamed(context, "/"),
      );
    return userID;
  }
}
