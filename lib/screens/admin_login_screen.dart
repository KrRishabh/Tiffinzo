import 'package:flutter/material.dart';
import 'package:tiffinzo_app/screens/admin_options_screen.dart';
import 'package:tiffinzo_app/services/constants.dart';

class AdminLoginScreen extends StatefulWidget {
  static const String id = 'AdminLoginScreen';

  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final String setPassword = 'rishuchikky';
  String adminName;
  String enteredPassword;
  String errorMsg = '';
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
              style: kTiffinzoTitle.copyWith(fontSize: 60),
            ),
            Text(
              'Login as Admin',
              style: kTiffinzoTitle.copyWith(fontSize: 30, color: Colors.black),
            ),
            TextField(
              cursorColor: kThemeColor,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  labelText: 'Enter your name',
                  hintText: 'Enter name',
                  labelStyle: TextStyle(color: kThemeColor),
                  fillColor: kThemeColor),
              onChanged: (value) {
                adminName = value;
              },
            ),
            TextField(
              cursorColor: kThemeColor,
              textAlign: TextAlign.center,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Enter admin password',
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
                onPressed: () {
                  if (enteredPassword == setPassword) {
                    setState(() {
                      errorMsg = 'Correct password';
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AdminOptionsScreen(adminName)));
                    });
                  } else {
                    setState(() {
                      errorMsg = 'Wrong password';
                    });
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
