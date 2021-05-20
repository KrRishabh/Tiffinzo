import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tiffinzo_app/services/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

class MainOrderScreen extends StatefulWidget {
  static const String id = 'MainOrderScreen';
  @override
  _MainOrderScreenState createState() => _MainOrderScreenState();
}

class _MainOrderScreenState extends State<MainOrderScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String price = '100';
  String foodTitle = 'random';
  String servingTime;
  String tempURL;
  String foodDetials;
  String orderStatus = 'Order not placed';
  bool orderPlaced = false;

  String imageURLnew =
      'https://images.ctfassets.net/3s5io6mnxfqz/6ZImCEzx6UuvuKaAiZEDDN/50479ee4a0902deb4eb1bab720ce248a/image1.jpg';

  String userID;
  String orderDocID;
  String timeCode;
  String errorMsg = '';
  String fullName;
  String mobileNumber;
  String emailid;
  String address;
  String pinCode;
  int totalAmount = 1;
  int numberOfOrder = 1;
  String specialInstruction;

  String getCurrentDatetime() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('HH:mm ,  dd MMM yyyy').format(now);
    print(formattedDate);
    timeCode = DateFormat('HHddMMM').format(now);
    print('timecode= $timeCode');
    return formattedDate;
  }

  String getUserID() {
    return _auth.currentUser.uid;
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

  void getMenuData() async {
    DocumentSnapshot dataSnapshot =
        await _firestore.collection('CurrentMenu').doc('CurrentMeal').get();
    setState(() {
      foodTitle = dataSnapshot.data()['FoodTitle'];
      tempURL = dataSnapshot.data()['ImageURL'];
      if (tempURL != null && tempURL != '') {
        imageURLnew = tempURL;
      }

      price = dataSnapshot.data()['Price'];
      servingTime = dataSnapshot.data()['ServingTime'];
      foodDetials = dataSnapshot.data()['FoodDetails'];
      totalAmount = int.parse(price);
    });
  }

  @override
  void initState() {
    super.initState();
    getMenuData();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    String currentImageURL = imageURLnew;

    return SafeArea(
        child: Scaffold(
      body: Container(
        color: kThemeColor,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Place your order',
                style:
                    kTiffinzoTitle.copyWith(fontSize: 40, color: Colors.white),
              ),
              Text(
                'Currently serving:',
                style:
                    kTiffinzoTitle.copyWith(fontSize: 20, color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 650,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: kMenuCardContainer,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 220,
                        child: Center(
                          child: Image.network(
                            imageURLnew,
                          ),
                        ),
                      ),
                      Text(
                        foodTitle,
                        style: kBoldText.copyWith(fontSize: 25),
                      ),
                      Text(
                        '₹ $price /-',
                        style:
                            kBoldText.copyWith(color: Colors.red, fontSize: 30),
                      ),
                      Text(
                        'Serving time: $servingTime',
                        style: kBoldText,
                      ),
                      Text(
                        foodDetials,
                        style: kInfoText,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: [
                              Text('Amount to pay:'),
                              Text(
                                '₹' + totalAmount.toString(),
                                style: kBoldText.copyWith(color: Colors.red),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(numberOfOrder.toString(),
                                  style: kBoldText.copyWith(
                                      color: Colors.red, fontSize: 30)),
                              Row(
                                children: [
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        color: kThemeColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        )),
                                    child: Center(
                                      child: GestureDetector(
                                          onTap: () {
                                            if (numberOfOrder > 1) {
                                              setState(() {
                                                numberOfOrder--;
                                                totalAmount = int.parse(price) *
                                                    numberOfOrder;
                                              });
                                            }
                                          },
                                          child: Text(
                                            '<',
                                            style: kButtonText.copyWith(
                                                fontSize: 15),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        color: kThemeColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        )),
                                    child: Center(
                                      child: GestureDetector(
                                          onTap: () {
                                            if (numberOfOrder < 10) {
                                              setState(() {
                                                numberOfOrder++;
                                                totalAmount = int.parse(price) *
                                                    numberOfOrder;
                                              });
                                            }
                                          },
                                          child: Text(
                                            '>',
                                            style: kButtonText.copyWith(
                                                fontSize: 15),
                                          )),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      TextField(
                        cursorColor: kThemeColor,
                        decoration: InputDecoration(
                            labelText: 'Any special instruction to us?',
                            hintText: 'Instructions',
                            labelStyle: TextStyle(color: kThemeColor),
                            fillColor: kThemeColor),
                        onChanged: (value) {
                          specialInstruction = value;
                        },
                      ),
                      Text(
                        errorMsg,
                        style: kInfoText,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: kButtonStyle.copyWith(
                            color: orderPlaced ? Colors.red : kThemeColor),
                        child: FlatButton(
                          onPressed: () async {
                            try {
                              if (!orderPlaced) {
                                await getUserData();
                                String dateTime = getCurrentDatetime();
                                String userID = getUserID();
                                orderDocID = timeCode + userID;
                                await _firestore
                                    .collection('OrderData')
                                    .doc(orderDocID)
                                    .set({
                                  'UserID': userID,
                                  'DateTime': dateTime,
                                  'FoodTitle': foodTitle,
                                  'FoodDescription': foodDetials,
                                  'OrderStatus': 'Order Placed',
                                  'UserName': fullName,
                                  'UserAddress': address,
                                  'UserPinCode': pinCode,
                                  'UserMobileNumber': mobileNumber,
                                  'UserEmailID': emailid,
                                  'SpecialInstructions': specialInstruction,
                                  'TotalAmount': totalAmount.toString(),
                                  'Quantity': numberOfOrder.toString(),
                                });
                                setState(() {
                                  orderPlaced = true;
                                });
                              } else if (orderPlaced) {
                                await _firestore
                                    .collection('OrderData')
                                    .doc(orderDocID)
                                    .delete();
                                setState(() {
                                  orderPlaced = false;
                                });
                              }
                            } catch (e) {
                              print(e);
                              setState(() {
                                errorMsg = 'Error : ' + e.toString();
                              });
                            }
                          },
                          child: Text(
                            orderPlaced ? 'Cancel Order' : 'Order',
                            style: kButtonText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                decoration: kButtonStyle.copyWith(color: kThemeColor),
                child: FlatButton(
                  child: Text(
                    'Log out',
                    style: kButtonText,
                  ),
                  onPressed: () {
                    _auth.signOut();
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
