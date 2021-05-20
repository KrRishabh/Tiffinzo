import 'package:flutter/material.dart';
import 'package:tiffinzo_app/services/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SetMenuScreen extends StatefulWidget {
  static const String id = 'SetMenuScreen';
  @override
  _SetMenuScreenState createState() => _SetMenuScreenState();
}

class _SetMenuScreenState extends State<SetMenuScreen> {
  String foodTitle;
  String price;
  String servingTime;
  String imageUrl;
  String yourName;
  String foodDetails;
  String statusMsg = '';
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
              SizedBox(
                height: 20,
              ),
              Text(
                'Enter Meal Details',
                style:
                    kTiffinzoTitle.copyWith(fontSize: 30, color: Colors.black),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                cursorColor: kThemeColor,
                decoration: InputDecoration(
                    labelText: 'Enter Title of food',
                    hintText: 'Food name',
                    labelStyle: TextStyle(color: kThemeColor),
                    fillColor: kThemeColor),
                onChanged: (value) {
                  foodTitle = value;
                },
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                cursorColor: kThemeColor,
                decoration: InputDecoration(
                    labelText: 'Enter image URL, Optional',
                    hintText: 'Copy/paste Image link here',
                    labelStyle: TextStyle(color: kThemeColor),
                    fillColor: kThemeColor),
                onChanged: (value) {
                  imageUrl = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'This image will be shown to the user along with details',
                style: kInfoText,
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                cursorColor: kThemeColor,
                decoration: InputDecoration(
                    labelText: 'Enter serving time',
                    hintText: 'Enter time interval',
                    labelStyle: TextStyle(color: kThemeColor),
                    fillColor: kThemeColor),
                onChanged: (value) {
                  servingTime = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Enter the time interval for which you will be taking orders on this meal',
                style: kInfoText,
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                cursorColor: kThemeColor,
                decoration: InputDecoration(
                    labelText: 'Enter price for this meal',
                    hintText: 'Enter Price',
                    labelStyle: TextStyle(color: kThemeColor),
                    fillColor: kThemeColor),
                onChanged: (value) {
                  price = value;
                },
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                cursorColor: kThemeColor,
                decoration: InputDecoration(
                    labelText: 'Enter full description of the meal',
                    hintText: 'Enter food details',
                    labelStyle: TextStyle(color: kThemeColor),
                    fillColor: kThemeColor),
                onChanged: (value) {
                  foodDetails = value;
                },
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                statusMsg,
                style: kInfoText,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                decoration: kButtonStyle,
                child: FlatButton(
                  onPressed: () async {
                    try {
                      await _firestore
                          .collection('CurrentMenu')
                          .doc('CurrentMeal')
                          .set({
                        'FoodTitle': foodTitle,
                        'ImageURL': imageUrl,
                        'Price': price,
                        'ServingTime': servingTime,
                        'FoodDetails': foodDetails,
                      });
                      setState(() {
                        statusMsg = 'Update Successful!';
                      });
                    } catch (e) {
                      print(e);
                      setState(() {
                        statusMsg = e.toString();
                      });
                    }
                  },
                  child: Text(
                    'Update Menu',
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
