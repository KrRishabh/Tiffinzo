import 'package:flutter/material.dart';
import 'package:tiffinzo_app/screens/opening_screen.dart';
import 'package:tiffinzo_app/services/constants.dart';
import 'package:tiffinzo_app/screens/login_screen.dart';
import 'package:tiffinzo_app/screens/registration_screen.dart';
import 'package:tiffinzo_app/screens/newuser_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tiffinzo_app/screens/main_order_screen.dart';
import 'package:tiffinzo_app/screens/verify_userData_screen.dart';
import 'package:tiffinzo_app/screens/admin_login_screen.dart';
import 'package:tiffinzo_app/screens/admin_options_screen.dart';
import 'package:tiffinzo_app/screens/set_menu_screen.dart';
import 'package:tiffinzo_app/screens/view_orders_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  return runApp(Tiffinzo());
}

class Tiffinzo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: ,
      theme: ThemeData.light().copyWith(
          primaryColor: kThemeColor,
          accentColor: kThemeColor,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: kThemeColor,
          )),
      initialRoute: OpeningScreen.id,
      routes: {
        OpeningScreen.id: (context) => OpeningScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        NewUserDetailsScreen.id: (context) => NewUserDetailsScreen(),
        MainOrderScreen.id: (context) => MainOrderScreen(),
        VerifyUserDataScreen.id: (context) => VerifyUserDataScreen(),
        AdminLoginScreen.id: (context) => AdminLoginScreen(),
        SetMenuScreen.id: (context) => SetMenuScreen(),
        ViewOrdersScreen.id: (context) => ViewOrdersScreen(),
      },
    );
  }
}
