import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiffinzo_app/screens/verify_userData_screen.dart';
import 'package:tiffinzo_app/services/constants.dart';

class NewUserDetailsScreen extends StatefulWidget {
  static const String id = "NewUserDetailsScreen";
  @override
  _NewUserDetailsScreenState createState() => _NewUserDetailsScreenState();
}

class _NewUserDetailsScreenState extends State<NewUserDetailsScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User loggedInUser;
  String userName;
  String fullName;
  String completeAddress;
  String pinCode;
  String mobileNumber;

  @override
  void initState() {
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final currUser = _auth.currentUser;
      if (currUser != null) {
        loggedInUser = currUser;
      }

      print('loggedInUser email = ${loggedInUser.email}');
      try {
        int len = loggedInUser.email.length;

        setState(() {
          userName = (loggedInUser.email).substring(0, len - 10);
        });
      } catch (e) {
        setState(() {
          userName = loggedInUser.email;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Tiffinzo',
                style: kTiffinzoTitle.copyWith(fontSize: 40),
              ),
              Text(
                'Enter your details',
                style:
                    kTiffinzoTitle.copyWith(fontSize: 30, color: Colors.black),
              ),
              Text(
                'for user: $userName',
                style: kTiffinzoTitle.copyWith(
                    fontSize: 20, color: Colors.black54),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                cursorColor: kThemeColor,
                decoration: InputDecoration(
                    labelText: 'Enter your full name',
                    hintText: 'Full name',
                    labelStyle: TextStyle(color: kThemeColor),
                    fillColor: kThemeColor),
                onChanged: (value) {
                  fullName = value;
                },
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                cursorColor: kThemeColor,
                decoration: InputDecoration(
                    labelText: 'Enter your mobile number',
                    hintText: 'Contact number',
                    labelStyle: TextStyle(color: kThemeColor),
                    fillColor: kThemeColor),
                onChanged: (value) {
                  mobileNumber = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'We might need this to confirm your order and during delivery',
                style: kInfoText,
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                cursorColor: kThemeColor,
                decoration: InputDecoration(
                    labelText: 'Enter your complete address',
                    hintText: 'Enter address',
                    labelStyle: TextStyle(color: kThemeColor),
                    fillColor: kThemeColor),
                onChanged: (value) {
                  completeAddress = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Enter your current address where you want your food delivered',
                style: kInfoText,
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                cursorColor: kThemeColor,
                decoration: InputDecoration(
                    labelText: 'Enter your location Pin code',
                    hintText: 'Enter Pin',
                    labelStyle: TextStyle(color: kThemeColor),
                    fillColor: kThemeColor),
                onChanged: (value) {
                  pinCode = value;
                },
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: double.infinity,
                decoration: kButtonStyle,
                child: FlatButton(
                  onPressed: () async {
                    try {
                      await _firestore
                          .collection('UserData')
                          .doc(loggedInUser.uid)
                          .set({
                        'FullName': fullName,
                        'Email': loggedInUser.email.toString(),
                        'ContactNumber': mobileNumber,
                        'Address': completeAddress,
                        'PinCode': pinCode,
                      });
                      Navigator.pushNamed(context, VerifyUserDataScreen.id);
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text(
                    'Next',
                    style: kButtonText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
