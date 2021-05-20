import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tiffinzo_app/services/constants.dart';
import 'package:tiffinzo_app/screens/main_order_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "LoginScreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String enteredEmail;
  String enteredPassword;
  String errorMsg = '.';
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
              'Login as an existing user',
              style: kTiffinzoTitle.copyWith(fontSize: 20, color: Colors.black),
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
                  labelText: 'Enter your password',
                  hintText: 'Enter password',
                  labelStyle: TextStyle(color: kThemeColor),
                  fillColor: kThemeColor),
              onChanged: (value) {
                enteredPassword = value;
              },
            ),
            Text(
              errorMsg,
              style: kInfoText,
            ),
            Container(
              width: double.infinity,
              decoration: kButtonStyle,
              child: FlatButton(
                onPressed: () async {
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: enteredEmail, password: enteredPassword);
                    if (user != null) {
                      print("Button pressed, user not null");
                      Navigator.pushNamed(context, MainOrderScreen.id);
                    } else {
                      print("Firebase vvalue is null, came into if");
                    }
                  } catch (e) {
                    print(e);
                    setState(() {
                      String  = e.toString();
                      int startIndex = authError.indexOf(']') + 1;
                      errorMsg =
                          authError.substring(startIndex, authError.length);
                      print('errorMsg = ${errorMsg.toString()}');
                    });authError
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
