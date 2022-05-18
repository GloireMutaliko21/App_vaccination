import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_connect/Screens/MainMenu/Screens/Enfants/enregistrer_screen.dart';
import 'package:v_connect/Screens/MainMenu/Screens/Enfants/modifier.dart';
//import 'package:v_connect/Screens/MainMenu/Screens/Enfants/modifier_screen.dart';
import 'package:v_connect/Screens/MainMenu/mainMenu_screen.dart';
import 'package:v_connect/app/source/data_source.dart';
import 'package:v_connect/constants.dart';
import 'package:http/http.dart' as http;
import 'package:v_connect/outils/constantes_class.dart';
import 'package:v_connect/outils/outils_app.dart';

class EnfantScreen extends StatefulWidget {
  const EnfantScreen({Key key}) : super(key: key);

  @override
  _EnfantScreenState createState() => _EnfantScreenState();
}

class _EnfantScreenState extends State<EnfantScreen> {
  List enfantList = [];

  // getEnfant(var idMere) async {
  //   var response = await http.post(
  //       Uri.parse("http://172.20.10.3/vConnectMobile/Accueil.php"),
  //       body: jsonEncode({"idMere": idMere}));
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       enfantList = jsonDecode(response.body);
  //     });
  //     return enfantList;
  //   }
  // }
  Future<void> getEnfant() async {
    await DataSource.getInstance.getEnfant(params: {
      "event": "FIND_ENFANT_ONLY",
      "idMere": MyPreferences.idMere
    }).then((value) {
      setState(() {
        Constantes.listMereEnfant = value;
      });
    });
  }

  Future<String> donnee({var data}) async {
    try {
      final response = await http.post(Uri.parse("${API_REST}ModifEnfant.php"),
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        var resultat = await jsonDecode(response.body);
        print(resultat);
        if (resultat.length > 0) {
          await MyPreferences.getInit.setPresistence(resultat).then((value) {
            print(MyPreferences.noms);
            //vider();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => Body(
                  removeDonnee: () async {
                    await removeDonnee();
                  },
                ),
              ),
            );
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Réessayez dans un instant",
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
    } catch (_) {
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

  void initDonnee() async {
    await donnee(data: {
      "noms": Constantes.listMereEnfant[0]['noms'],
      "idMere": MyPreferences.idMere,
    }).then((value) {
      print(value);
    });
  }

  int statut = 0;
  Future<void> removeDonnee() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    setState(() {
      p.remove("idEnfant");
      p.remove("noms");
      p.remove("dateNaissance");
      p.remove("poids");
      p.remove("taille");
      p.remove("carte");
      p.commit();
      print(MyPreferencesEnfant.idEnfant);
    });
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (builder) => MainMenuScreen(
                logOut: () {},
              )),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    getEnfant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 32,
        backgroundColor: Color.fromARGB(210, 220, 240, 240),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              getEnfant();
            },
            icon: Icon(Icons.refresh, color: kPrimaryColor),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/BackV.png"), fit: BoxFit.cover),
        ),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          itemCount: Constantes.listMereEnfant.length,
          itemBuilder: (context, i) {
            return Container(
              color: Colors.grey,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (builder) => ModifierScreen(),
                      //   ),
                      // );
                      setState(() {
                        initDonnee();
                      });
                    },
                    minVerticalPadding: 8,
                    contentPadding: EdgeInsets.symmetric(horizontal: 6.0),
                    leading: Text(
                      "Né(e) le : ${Constantes.listMereEnfant[i]['dateNaissance']}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    title: Text(
                      Constantes.listMereEnfant[i]['noms'],
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    subtitle: Container(
                      child: Column(
                        children: [
                          Text(
                            "Sexe : ${Constantes.listMereEnfant[i]['sexe']}",
                            style: TextStyle(
                                color: Colors.brown.shade700,
                                fontWeight: FontWeight.normal,
                                fontSize: 12),
                          ),
                          Text(
                            "Poids : ${Constantes.listMereEnfant[i]['poids']} grammes",
                            style: TextStyle(
                                color: Colors.brown.shade700,
                                fontWeight: FontWeight.normal,
                                fontSize: 12),
                          ),
                          Text(
                            "Taille : ${Constantes.listMereEnfant[i]['taille']}Cm",
                            style: TextStyle(
                                color: Colors.brown.shade700,
                                fontWeight: FontWeight.normal,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return EnregistrerScreen();
              },
            ),
          );
        },
        child: Icon(Icons.person_add_sharp),
      ),
    );
  }
}
