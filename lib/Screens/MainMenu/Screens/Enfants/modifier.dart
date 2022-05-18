import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:v_connect/Screens/Signup/components/background.dart';
import 'package:v_connect/components/rounded_button.dart';
import 'package:v_connect/components/rounded_input_field.dart';
import 'package:v_connect/constants.dart';
import 'package:http/http.dart' as http;
import 'package:v_connect/outils/constantes_class.dart';
import 'package:v_connect/outils/outils_app.dart';

class Body extends StatefulWidget {
  final VoidCallback removeDonnee;
  const Body({
    Key key,
    @required this.removeDonnee,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var dateNaisse = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String sexe;

  get err => null;
  void initState() {
    super.initState();
  }

  // Future<String> getDonnee() {
  //   nom = MyPreferencesEnfant.idEnfant;
  // }

  Future<String> register({var data}) async {
    try {
      final response = await http.post(Uri.parse("${API_REST}AddEnfant.php"),
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        if (nom.text.isNotEmpty ||
            lieu.text.isNotEmpty ||
            dateNaisse.text.isNotEmpty ||
            poids.text.isNotEmpty ||
            taille.text.isNotEmpty ||
            numCarte.text.isNotEmpty) {
          try {
            var resultat = await jsonDecode(response.body);
            resultat.forEach((data) => {print(data)});
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Enfant enregistré",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.transparent,
            ));
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "${e.toString()} Echec ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.transparent,
            ));
          }
        }
      }
    } catch (_) {
      print("${_.toString()}");
    }
    return null;
  }

  void vider() {
    nom.clear();
    lieu.text = "";
    poids.clear();
    taille.clear();
    numCarte.clear();
  }

  Future<bool> initData() async {
    await register(data: {
      "noms": nom.text,
      "lieuNaiss": lieu.text,
      "dateNaissance": dateNaisse.text,
      "sexe": sexe.substring(0, 1),
      "poids": poids.text,
      "taille": taille.text,
      "numCarteVacc": numCarte.text,
      "idMere": MyPreferences.idMere,
      "idHopital": MyPreferences.idHopital
    }).then((value) {
      return true;
    });
    return false;
  }

  TextEditingController nom = new TextEditingController();
  TextEditingController lieu = new TextEditingController();
  TextEditingController poids = new TextEditingController();
  TextEditingController taille = new TextEditingController();
  TextEditingController numCarte = new TextEditingController();

  initDate() async {
    selectedDate = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(2050)));
    if (selectedDate != null)
      setState(() {
        dateNaisse.text = selectedDate.toString().substring(0, 10);
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "MODIFICATIONS",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                RoundedInputField(
                  controller: nom,
                  hintText: "nom complet",
                  textInputType: TextInputType.name,
                  icon: Icons.admin_panel_settings_outlined,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter(RegExp("[a-zA-ZÄäÖöÜü]"))
                  ],
                ),
                RoundedInputField(
                  controller: lieu,
                  hintText: "Lieu naissance",
                  textInputType: TextInputType.name,
                  icon: Icons.place_outlined,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter(RegExp("[a-zA-ZÄäÖöÜü0-9]"))
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.circular(29)),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Date de naissance",
                        icon: Icon(
                          Icons.calendar_today,
                          color: kPrimaryColor,
                        ),
                      ),
                      controller: dateNaisse,
                      readOnly: true,
                      onTap: () {
                        setState(() {
                          initDate();
                        });
                      },
                    ),
                  ),
                ]),
                Container(
                    child: cbList(
                        title: "Sexe",
                        list: isList(value: ["Féminin", "Masculin"]),
                        onChanged: (val) {
                          setState(() {
                            sexe = val;
                          });
                        })),
                RoundedInputField(
                  controller: poids,
                  hintText: "Poids (En grammes)",
                  maxLengt: 3,
                  textInputType: TextInputType.number,
                  icon: Icons.accessibility_new_outlined,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter(RegExp("[0-9]"))
                  ],
                ),
                RoundedInputField(
                  controller: taille,
                  hintText: "Taille (En Cm)",
                  maxLengt: 2,
                  textInputType: TextInputType.number,
                  icon: Icons.height_sharp,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter(RegExp("[0-9]"))
                  ],
                ),
                RoundedInputField(
                  controller: numCarte,
                  hintText: "Numéro carte",
                  textInputType: TextInputType.number,
                  icon: Icons.format_list_numbered,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter(RegExp("[0-9]"))
                  ],
                ),
                // RoundeCbList(
                //   size: size,
                //   items: hopital,
                //   hint: "Hôpital",
                // ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                RoundedButton(
                    text: "MODIFIER",
                    press: () async {
                      widget.removeDonnee.call();
                      // await initData().then((value) {

                      //   value = true;
                      //   if (value) {
                      //     setState(() {
                      //       vider();
                      //     });
                      //   }
                      // });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
