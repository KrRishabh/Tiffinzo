import 'package:flutter/material.dart';
import 'package:tiffinzo_app/screens/admin_login_screen.dart';
import 'package:tiffinzo_app/screens/login_screen.dart';
import 'package:tiffinzo_app/screens/registration_screen.dart';
import 'package:tiffinzo_app/services/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OpeningScreen extends StatefulWidget {
  static const String id = "OpeningScreen";
  @override
  _OpeningScreenState createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tiffinzo',
                    style: kTiffinzoTitle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimatedTextKit(
                      onTap: () {
                        print("Tap Event");
                      },
                      repeatForever: true,
                      text: [
                        "Online Tiffin Service",
                        "Home-cooked food",
                        "Based in Patna",
                      ],
                      textStyle:
                          TextStyle(fontSize: 20.0, fontFamily: "Bangers"),
                      textAlign: TextAlign.start,
                      alignment:
                          AlignmentDirectional.topStart // or Alignment.topLeft
                      ),
                ],
              ),
            ),
            Divider(
              height: 5,
              thickness: 2,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: kButtonStyle,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: Text(
                        'Login',
                        style: kButtonText,
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    width: double.infinity,
                    decoration: kButtonStyle,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                      child: Text(
                        'Register',
                        style: kButtonText,
                      ),
                    ),
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AdminLoginScreen.id);
                      },
                      child: Text(
                        'OR sign-in as Admin',
                        style: kAdditionalText,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
