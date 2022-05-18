import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:v_connect/constants.dart';
import 'package:v_connect/outils/constantes_class.dart';

class ConseilScreen extends StatefulWidget {
  const ConseilScreen({Key key}) : super(key: key);

  @override
  _ConseilScreenState createState() => _ConseilScreenState();
}

class _ConseilScreenState extends State<ConseilScreen> {
  List conseilList = [];

  getAllConseil() async {
    var response = await http.get(Uri.parse("${API_REST}LireConseil.php"));
    if (response.statusCode == 200) {
      setState(() {
        conseilList = json.decode(response.body);
      });
      return conseilList;
    }
  }

  @override
  void initState() {
    super.initState();
    getAllConseil();
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Color.fromARGB(210, 220, 240, 240).withOpacity(0.7),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              getAllConseil();
            },
            icon: Icon(Icons.refresh, color: kPrimaryColor),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(210, 220, 240, 240),
          // image: DecorationImage(
          //     image: AssetImage("assets/images/BackV.png"), fit: BoxFit.cover),
        ),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          itemCount: conseilList.length,
          itemBuilder: (context, i) {
            return Container(
              color: Colors.grey,
              child: Column(
                children: [
                  ListTile(
                    minVerticalPadding: 8,
                    contentPadding: EdgeInsets.symmetric(horizontal: 6.0),
                    leading: Text(
                      conseilList[i]['datePub'],
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    title: Text(
                      conseilList[i]['contenu'],
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    ),
                    // trailing: RaisedButton.icon(
                    //   onPressed: () {},
                    //   icon: Icon(Icons.add),
                    //   label: Text(label),
                    // ),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
