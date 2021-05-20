import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tiffinzo_app/services/constants.dart';
import 'package:tiffinzo_app/screens/login_screen.dart';

class VerifyUserDataScreen extends StatefulWidget {
  static const String id = 'VerifyUserDataScreen';
  @override
  _VerifyUserDataScreenState createState() => _VerifyUserDataScreenState();
}

class _VerifyUserDataScreenState extends State<VerifyUserDataScreen> {
  String fullName;
  String mobileNumber;
  String address;
  String emailid;
  String pinCode;
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    getUserData();
  }

  void getUserData() async {
    DocumentSnapshot dataSnapshot = await _firestore
        .collection('UserData')
        .doc(_auth.currentUser.uid)
        .get();
    setState(() {
      fullName = dataSnapshot.data()['FullName'];
      mobileNumber = dataSnapshot.data()['ContactNumber'];
      address = dataSnapshot.data()['Address'];
      emailid = dataSnapshot.data()['Email'];
      pinCode = dataSnapshot.data()['PinCode'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: Column(
          children: <Widget>[
            Text(
              'Confirm your details',
              style: kAdditionalTitle,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Full Name: $fullName',
                    style: kBoldText,
                  ),
                  Text(
                    'Contact Number: $mobileNumber',
                    style: kBoldText,
                  ),
                  Text(
                    'Address: $address',
                    style: kBoldText,
                  ),
                  Text(
                    'Pin code: $pinCode',
                    style: kBoldText,
                  ),
                  Text(
                    'Email: $emailid',
                    style: kBoldText,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: kButtonStyle,
              width: double.infinity,
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Make changes',
                  style: kButtonText,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: kButtonStyle,
              width: double.infinity,
              child: FlatButton(
                onPressed: () async {
                  await _auth.signOut();

                  Navigator.pushNamed(context, LoginScreen.id);
                },
                child: Text(
                  'Confirm and proceed to Login',
                  style: kButtonText,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
