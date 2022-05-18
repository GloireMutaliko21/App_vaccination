import 'package:flutter/material.dart';
import 'package:v_connect/Screens/Login/components/body.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(210, 220, 240, 240),
          toolbarHeight: 30,
          centerTitle: true,
          title: Text(
            "vConnect",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Body(),
      ),
    );
  }
}
