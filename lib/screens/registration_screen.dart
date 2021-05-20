import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tiffinzo_app/screens/newuser_details_screen.dart';
import 'package:tiffinzo_app/services/constants.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "RegistrationScreen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String enteredEmail;
  String enteredPassword;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Tiffinzo',
              style: kTiffinzoTitle.copyWith(fontSize: 40),
            ),
            Text(
              'Register yourself',
              style: kTiffinzoTitle.copyWith(fontSize: 30, color: Colors.black),
            ),
            TextField(
              cursorColor: kThemeColor,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  labelText: 'Enter E-mail address',
                  hintText: 'Enter email',
                  labelStyle: TextStyle(color: kThemeColor),
                  fillColor: kThemeColor),
              onChanged: (value) {
                enteredEmail = value;
              },
            ),
            TextField(
              cursorColor: kThemeColor,
              textAlign: TextAlign.center,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Set a password',
                  hintText: 'Enter password',
                  labelStyle: TextStyle(color: kThemeColor),
                  fillColor: kThemeColor),
              onChanged: (value) {
                enteredPassword = value;
              },
            ),
            Container(
              width: double.infinity,
              decoration: kButtonStyle,
              child: FlatButton(
                onPressed: () async {
                  print('email = $enteredEmail , password = $enteredPassword');
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: enteredEmail, password: enteredPassword);
                    if (newUser != null) {
                      Navigator.pushNamed(context, NewUserDetailsScreen.id);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text(
                  'Next',
                  style: kButtonText,
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
