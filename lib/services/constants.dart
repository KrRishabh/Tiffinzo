import 'package:flutter/material.dart';

TextStyle kTiffinzoTitle =
    TextStyle(fontSize: 60, color: kThemeColor, fontFamily: 'Bangers');
Color kThemeColor = Colors.green.shade800;

TextStyle kAdditionalTitle =
    TextStyle(fontSize: 30, color: kThemeColor, fontFamily: 'Bangers');

TextStyle kBoldText =
    TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold);

TextStyle kButtonText = TextStyle(color: Colors.white, fontSize: 20);
TextStyle kAdditionalText =
    TextStyle(color: kThemeColor, fontSize: 20, fontWeight: FontWeight.bold);
TextStyle kInfoText = TextStyle(color: Colors.black54, fontSize: 12);

BoxDecoration kButtonStyle = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(20)), color: kThemeColor);

BoxDecoration kMenuCardContainer = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(20)),
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.5),
      spreadRadius: 3,
      blurRadius: 7,
      offset: Offset(0, 3), // changes position of shadow
    ),
  ],
);
