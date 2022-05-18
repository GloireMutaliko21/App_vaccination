import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:v_connect/Screens/MainMenu/Screens/Enfants/Table/mesEnfats_tb.dart';
import 'package:v_connect/Screens/MainMenu/Screens/calendriers.dart';
import 'package:v_connect/Screens/MainMenu/Screens/compteMere.dart';
import 'package:v_connect/Screens/MainMenu/Screens/conseils.dart';
import 'package:v_connect/Screens/MainMenu/Screens/home.dart';
import 'package:v_connect/Screens/MainMenu/Screens/mesEnfants.dart';
import 'package:v_connect/Screens/MainMenu/Screens/calendars.dart';
import 'package:v_connect/constants.dart';
import 'package:v_connect/outils/constantes_class.dart';
import 'package:v_connect/outils/outils_app.dart';
import 'package:http/http.dart' as http;

class MainMenuScreen extends StatefulWidget {
  final VoidCallback logOut;
  const MainMenuScreen({
    Key key,
    @required this.logOut,
  }) : super(key: key);

  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  int selectedIndex = 2;
  String appbar = "";
  Icon icon = Icon(Icons.date_range);
  final screen = [
    CompteMereScreen(),
    MesEnfatsTb(),
    HomeScreen(),
    Calendriers(),
    ConseilScreen(),
  ];

  void appBars() {
    setState(() {
      if (selectedIndex == 0) {
        appbar = "Mes informations";
        icon = Icon(Icons.person_search_rounded, color: kPrimaryColor);
      } else if (selectedIndex == 1) {
        appbar = "Gérer vos enfants";
        icon = Icon(Icons.baby_changing_station_rounded, color: kPrimaryColor);
      } else if (selectedIndex == 2) {
        appbar = "Bienvenu";
        icon = Icon(
          Icons.list,
          color: Colors.transparent,
        );
      } else if (selectedIndex == 3) {
        appbar = "Calendriers vaccinaux";
        icon = Icon(Icons.date_range, color: kPrimaryColor);
      } else if (selectedIndex == 4) {
        appbar = "Informations et conseils";
        icon = Icon(Icons.info_outline, color: kPrimaryColor);
      }
    });
  }

  FlutterLocalNotificationsPlugin localNotification;

  @override
  void initState() {
    super.initState();
    initData();
    // var androidInitialize = new AndroidInitializationSettings('vaccin');
    // var iOSinitialize = new IOSInitializationSettings();
    // var initilizationSettings = new InitializationSettings(
    //     android: androidInitialize, iOS: iOSinitialize);
    // localNotification = new FlutterLocalNotificationsPlugin();
    // localNotification.initialize(initilizationSettings);

    // _showNotification();
  }

  var total;
  getNotif({data}) async {
    try {
      final response = await http.post(Uri.parse("${API_REST}notif.php"),
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        setState(() {
          total = jsonDecode(response.body);
        });
      }
    } on SocketException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Echec de connexion ${e.toString()}",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        backgroundColor: kPrimaryColor,
      ));
    }
    return total;
  }

  Future<bool> initData() async {
    await getNotif(data: {
      "idMere": MyPreferences.idMere,
    }).then((value) {
      return true;
    });
    return false;
  }

  // Future _showNotification() async {
  //   setState(() {
  //     getEnfant();
  //   });
  //   var androidDetails = new AndroidNotificationDetails(
  //       "channelId",
  //       "Local Notification",
  //       "This is the description of the Notification, anything can be written",
  //       importance: Importance.high);
  //   var iOSdetails = new IOSNotificationDetails();
  //   var generalNotificationDetails =
  //       new NotificationDetails(android: androidDetails, iOS: iOSdetails);
  //   print(MyPreferences.idMere);
  //   print(Constantes.listMere);
  //   await localNotification.show(
  //       0,
  //       "Alert notification",
  //       "La date de vaccination (${Constantes.listMere[0]['datePrev']}) prévue le vaccin ${Constantes.listMere[0]['nomVaccin']} pour votre enfant ${Constantes.listMere[0]['noms']} est au rendez-vous",
  //       generalNotificationDetails);
  // }
  bool isSeen = true;
  @override
  Widget build(BuildContext context) {
    appBars();
    return SafeArea(
      child: Scaffold(
        //screen[selectedIndex]
        drawer: Drawer(
          child: Material(
            // color: Color.fromRGBO(50, 75, 205, 1),
            color: kPrimaryColor.withOpacity(0.87),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: <Widget>[
                DrawerHeader(
                  child: Row(children: <Widget>[
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(
                        "assets/images/pharma.jpg",
                      ),
                      backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 45,
                        ),
                        Text(
                          "vConnect",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "mufunyig@gmail.com",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
                Divider(
                  color: Colors.yellow,
                ),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.white, size: 20),
                  title: Text(
                    "Deconnexion",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {
                    setState(() {
                      widget.logOut.call();
                    });
                  },
                ),
                ListTile(
                  leading: Icon(Icons.contact_mail_outlined,
                      color: Colors.white, size: 20),
                  title: Text(
                    "Contactez-nous",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {
                    // _showNotification();
                  },
                  onLongPress: () {
                    // _showNotification();
                  },
                ),
                ListTile(
                  leading:
                      Icon(Icons.info_outline, color: Colors.white, size: 20),
                  title: Text(
                    "A propos",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {},
                ),
                Divider(
                  color: Colors.white,
                ),
                ListTile(
                  leading: Icon(
                    Icons.help_outline,
                    color: Colors.white,
                    size: 20,
                  ),
                  title: Text(
                    "Aide",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),

        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          toolbarHeight: 45,
          centerTitle: true,
          title: Text(
            "$appbar",
            style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            isSeen
                ? Padding(
                    padding: const EdgeInsets.all(11.5),
                    child: InkWell(
                      onTap: () {
                        debugPrint("seen");
                      },
                      child: Badge(
                        badgeContent: Text(total.toString()),
                        child: Icon(Icons.notifications_active),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(11.5),
                    child: InkWell(
                      onTap: () {},
                      child: Badge(
                        badgeContent: Text("0"),
                        child: Icon(Icons.notifications_none),
                      ),
                    ),
                  )
          ],
        ),
        body: screen[selectedIndex],
        bottomNavigationBar: CurvedNavigationBar(
          index: selectedIndex,
          items: [
            Icon(
              Icons.person_search_rounded,
              color: kPrimaryColor,
              size: 25,
            ),
            Icon(
              Icons.baby_changing_station_rounded,
              color: kPrimaryColor,
              size: 25,
            ),
            Icon(
              Icons.home,
              color: kPrimaryColor,
              size: 25,
            ),
            Icon(
              Icons.date_range_rounded,
              color: kPrimaryColor,
              size: 25,
            ),
            Icon(
              Icons.info_outline,
              color: kPrimaryColor,
              size: 25,
            ),
          ],
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          animationCurve: Curves.easeOutBack,
          color: Color.fromARGB(210, 220, 240, 240),
          height: 45,
          backgroundColor: Color.fromARGB(250, 250, 255, 240),
        ),
      ),
    );
  }
}
