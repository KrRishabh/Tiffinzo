import 'package:flutter/material.dart';
import 'package:tiffinzo_app/screens/set_menu_screen.dart';
import 'package:tiffinzo_app/services/constants.dart';
import 'package:tiffinzo_app/screens/view_orders_screen.dart';

class AdminOptionsScreen extends StatefulWidget {
  static const String id = 'AdminOptionsScreen';
  String adminName;
  AdminOptionsScreen(this.adminName);
  @override
  _AdminOptionsScreenState createState() => _AdminOptionsScreenState(adminName);
}

class _AdminOptionsScreenState extends State<AdminOptionsScreen> {
  String adminName;
  _AdminOptionsScreenState(this.adminName);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock,
              color: Colors.green,
              size: 60,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              ' Admin Portal',
              style: kTiffinzoTitle.copyWith(fontSize: 50),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Welcome , $adminName',
              style: kTiffinzoTitle.copyWith(fontSize: 20, color: Colors.black),
            ),
            SizedBox(
              height: 120,
            ),
            Container(
              width: double.infinity,
              decoration: kButtonStyle,
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, SetMenuScreen.id);
                },
                child: Text(
                  'Set Menu',
                  style: kButtonText,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              decoration: kButtonStyle,
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, ViewOrdersScreen.id);
                },
                child: Text(
                  'View Orders',
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
