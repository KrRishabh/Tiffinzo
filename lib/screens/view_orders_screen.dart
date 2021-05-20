import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tiffinzo_app/services/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewOrdersScreen extends StatefulWidget {
  static const String id = 'ViewOrdersScreen';
  @override
  _ViewOrdersScreenState createState() => _ViewOrdersScreenState();
}

class _ViewOrdersScreenState extends State<ViewOrdersScreen> {
  int count = 1;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'All orders',
              style: kAdditionalTitle,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('OrderData').snapshots(),
                builder: (context, snapshot) {
                  List<Widget> widgetList = [];
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  count = 1;
                  final orderList = snapshot.data.docs.reversed;
                  for (var orderMember in orderList) {
                    String cardNumber = count.toString();
                    count++;
                    String userID = orderMember.data()['UserID'];
                    String foodTitle = orderMember.data()['FoodTitle'];
                    String foodDescription =
                        orderMember.data()['FoodDescription'];
                    String dateTime = orderMember.data()['DateTime'];
                    String userName = orderMember.data()['UserName'];
                    String userAddress = orderMember.data()['UserAddress'];
                    String userPincode = orderMember.data()['UserPinCode'];
                    String userMobileNumber =
                        orderMember.data()['UserMobileNumber'];
                    String userEmailid = orderMember.data()['UserEmailID'];
                    String specialInstructions =
                        orderMember.data()['SpecialInstructions'];
                    String quantity = orderMember.data()['Quantity'];
                    String totalAmount = orderMember.data()['TotalAmount'];

                    Widget tempWidget = Container(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 400,
                          padding: EdgeInsets.symmetric(
                              vertical: 40, horizontal: 20),
                          decoration: kMenuCardContainer,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                'Client: $userName',
                                style: kBoldText.copyWith(
                                    color: Colors.red, fontSize: 30),
                              ),
                              Text(
                                'Food: $foodTitle',
                                style: kBoldText,
                              ),
                              Text(
                                foodDescription,
                                style: kInfoText,
                              ),
                              Text(
                                'Address: $userAddress',
                                style: kBoldText.copyWith(fontSize: 15),
                              ),
                              Text(
                                'Pin code: $userPincode',
                                style: kBoldText.copyWith(fontSize: 15),
                              ),
                              Text(
                                'Contact: $userMobileNumber',
                                style: kBoldText.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'E-mail: $userEmailid',
                                style: kBoldText.copyWith(
                                    fontSize: 15, color: Colors.black54),
                              ),
                              Text(
                                'Special Instructions: $specialInstructions',
                                style: kBoldText.copyWith(fontSize: 15),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Quantity: $quantity',
                                    style: kBoldText.copyWith(
                                        color: Colors.red, fontSize: 15),
                                  ),
                                  Text(
                                    'Amount to pay: $totalAmount',
                                    style: kBoldText.copyWith(
                                        color: Colors.red, fontSize: 15),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                dateTime,
                                style: kBoldText.copyWith(color: kThemeColor),
                              ),
                              Text(cardNumber),
                            ],
                          ),
                        ));
                    widgetList.add(tempWidget);
                  }

                  return Expanded(
                    child: ListView(
                      reverse: true,
                      children: widgetList,
                    ),
                  );
                }),
            Container(
              decoration: kButtonStyle,
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Back',
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
