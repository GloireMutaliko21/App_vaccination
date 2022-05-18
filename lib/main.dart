import 'package:flutter/material.dart';
import 'package:v_connect/Screens/Login/login_screen.dart';
import 'package:v_connect/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'mS-vConnect',
      theme: ThemeData(
          primaryColor: kPrimaryColor, scaffoldBackgroundColor: Colors.white),
      home: LoginScreen(),
    );
  }
}
