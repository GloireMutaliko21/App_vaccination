import 'package:flutter/material.dart';
import 'package:v_connect/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context)
        .size; //This size provide us total heignt and width of our screen
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              color: kPrimaryColor,
              child: Column(
                children: <Widget>[
                  Text(
                    "BIENVENUE DANS vConnect",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  SvgPicture.asset(
                    "assets/icons/bx-health.svg",
                    color: Color.fromARGB(210, 220, 240, 240),
                    height: size.height * 0.3,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
