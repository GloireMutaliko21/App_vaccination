import 'package:flutter/material.dart';
import 'package:v_connect/Screens/Welcome/components/body.dart';
import 'package:v_connect/constants.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(210, 220, 240, 240),
          toolbarHeight: 30,
          centerTitle: true,
          leading: Icon(
            Icons.medication,
            color: kPrimaryColor,
          ),
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
