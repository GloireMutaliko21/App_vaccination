import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/BackV.png"), fit: BoxFit.cover),
      ),
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Positioned(
          // top: 0,
          // left: 0,
          //child: Image.asset(
          //"assets/images/topOk.jpg",
          //width: size.width * 0.3,
          //),
          // ),
          //Positioned(
          //bottom: 0,
          //right: 0,
          //child: Image.asset(
          //"assets/images/bottom1.jpg",
          //width: size.width * 0.3,
          // ),
          // ),
          child,
        ],
      ),
    );
  }
}
