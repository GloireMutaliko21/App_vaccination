import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_connect/Screens/Login/components/background.dart';
import 'package:v_connect/Screens/Login/login_screen.dart';
import 'package:v_connect/Screens/MainMenu/mainMenu_screen.dart';
import 'package:v_connect/Screens/Signup/s_enregistrer_screen.dart';
import 'package:v_connect/components/already_have_an_account_acheck.dart';
import 'package:v_connect/components/rounded_button.dart';
import 'package:v_connect/components/rounded_input_field.dart';
import 'package:v_connect/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:v_connect/constants.dart';
import 'package:http/http.dart' as http;
import 'package:v_connect/outils/constantes_class.dart';
import 'package:v_connect/outils/outils_app.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int status = 0;

  Future<void> initSession() async {
    await MyPreferences.getInit.getPresistence().then((value) {
      setState(() {
        status = ifExist;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initSession();
  }

  int get ifExist {
    print("==========================>${MyPreferences.idMere}");
    if (MyPreferences.idMere != null) {
      return 1;
    } else {
      return 0;
    }
  }

  Map user;

  Future<void> logOut() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    setState(() {
      p.remove("idMere");
      status = 0;
      p.commit();
    });
    print(status);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (builder) => LoginScreen(),
      ),
      (route) => false,
    );
  }

  Future<String> login({var data}) async {
    try {
      final response = await http.post(Uri.parse("${API_REST}Login.php"),
          body: jsonEncode(data));

      if (response.statusCode == 200) {
        var resultat = await jsonDecode(response.body);
        print(resultat);
        if (resultat.length > 0) {
          await MyPreferences.getInit.setPresistence(resultat).then((value) {
            print(MyPreferences.noms);
            vider();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (builder) => MainMenuScreen(logOut: () async {}),
              ),
              (route) => false,
            );
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Echec de connexion",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              textAlign: TextAlign.center,
            ),
            backgroundColor: kPrimaryColor.withOpacity(0.5),
          ));
        }
      }
    } on SocketException catch (_) {
      print("${_.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Echec de connexion",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        backgroundColor: kPrimaryColor,
      ));
    }
    return null;
  }

  TextEditingController log = new TextEditingController();
  TextEditingController pw = new TextEditingController();
  void vider() {
    log.clear();
    pw.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    switch (status) {
      case 0:
        return Scaffold(
          body: Background(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "ESPACE DE CONNEXION",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  SvgPicture.asset(
                    "assets/icons/login_icon.svg",
                    color: kPrimaryColor,
                    height: size.height * 0.25,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  RoundedInputField(
                    controller: log,
                    hintText: "Entrez votre login",
                    onChanged: (value) {},
                    textInputType: TextInputType.text,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(
                          RegExp("[a-zA-ZÄäÖöÜü0-9]"))
                    ],
                  ),
                  RoundedPasswordField(
                    controller: pw,
                    hint: "Mot de passe",
                  ),
                  Container(
                    child: isLoad
                        ? Container(
                            width: 60,
                            height: 60,
                            color: Colors.transparent,
                            child: Center(
                              child: SpinKitChasingDots(
                                color: kPrimaryColor,
                              ),
                            ),
                          )
                        : RoundedButton(
                            text: "SE CONNECTER",
                            press: () {
                              setState(() {
                                initData();
                              });
                            },
                          ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => SenregistrerScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
        break;
      case 1:
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MainMenuScreen(logOut: () async {
                  await logOut();
                });
              },
            ),
          );
        });
        break;
      default:
    }
    return Scaffold();
  }

  bool isLoad = false;

  void initData() async {
    setState(() {
      isLoad = true;
    });
    await login(data: {
      "loginM": log.text,
      "pwM": pw.text,
    }).then((value) {
      initSession();
      setState(() {
        isLoad = false;
      });
      print(value);
      isLoad = false;
    });
  }
}
