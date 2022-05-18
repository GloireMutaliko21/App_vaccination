import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:v_connect/Screens/Signup/components/background.dart';
//import 'package:v_connect/app/source/data_source.dart';
import 'package:v_connect/components/rounded_button.dart';
import 'package:v_connect/components/rounded_input_field.dart';
import 'package:v_connect/constants.dart';
import 'package:http/http.dart' as http;
import 'package:v_connect/outils/constantes_class.dart';
import 'package:v_connect/outils/outils_app.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  final Widget child;
  const Body({
    Key key,
    @required this.child,
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

  // Future<void> registerCal({var data}) async {
  //   await DataSource.getInstance.insert(params: {
  //     "event": "ADD_CAL_ENFANT",
  //     "datePrev": datePrev.toString(),
  //     "idVaccin": idVaccin.toString()
  //   }).then((value) {
  //     // setState(() {
  //     //   Constantes.listMere = value;
  //     // });
  //   });
  // }

  Future<String> registerCal({var data}) async {
    try {
      final response = await http.post(Uri.parse("${API_REST}AddCal.php"),
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        try {
          var resultat = await jsonDecode(response.body);
          resultat.forEach((data) => {print(data)});
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "${e.toString()} Echec de calendrier",
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
    } catch (_) {
      print("${_.toString()}");
    }
    return null;
  }

  String datePrev, datePrev2, datePrev3, datePrev4;
  int idVaccin = 3, idVaccin2 = 7, idVaccin3 = 11, idVaccin4 = 15, joursEnf;

  final DateTime dateNow = new DateTime.now();
  DateFormat formatter = new DateFormat('yyyy-MM-dd');
  String dateformatted;

  void findDateAndVacc() {
    setState(() {
      joursEnf = dateNow.difference(selectedDate).inDays;
      dateformatted = formatter.format(dateNow);
      print(joursEnf);
      datePrev = formatter.format(dateNow.add(Duration(days: (42 - joursEnf))));
      datePrev2 =
          formatter.format(dateNow.add(Duration(days: (70 - joursEnf))));
      datePrev3 =
          formatter.format(dateNow.add(Duration(days: (98 - joursEnf))));
      datePrev4 =
          formatter.format(dateNow.add(Duration(days: (270 - joursEnf))));

      if (dateformatted == dateNaisse.text) {
        for (var i = 0; i < 4; i++) {
          i == 0
              ? registerCal(data: {
                  "datePrev": datePrev.toString(),
                  "idVaccin": idVaccin,
                }).then((value) {
                  return true;
                })
              : i == 1
                  ? registerCal(data: {
                      "datePrev": datePrev2.toString(),
                      "idVaccin": idVaccin2,
                    }).then((value) {
                      return true;
                    })
                  : i == 2
                      ? registerCal(data: {
                          "datePrev": datePrev3.toString(),
                          "idVaccin": idVaccin3,
                        }).then((value) {
                          return true;
                        })
                      : i == 3
                          ? registerCal(data: {
                              "datePrev": datePrev4.toString(),
                              "idVaccin": idVaccin4,
                            }).then((value) {
                              return true;
                            })
                          : null;
        }
      } else if ((joursEnf > 42) && (joursEnf < 70)) {
        for (var i = 0; i < 3; i++) {
          i == 0
              ? registerCal(data: {
                  "datePrev": datePrev2.toString(),
                  "idVaccin": idVaccin2,
                }).then((value) {
                  return true;
                })
              : i == 1
                  ? registerCal(data: {
                      "datePrev": datePrev3.toString(),
                      "idVaccin": idVaccin3,
                    }).then((value) {
                      return true;
                    })
                  : i == 2
                      ? registerCal(data: {
                          "datePrev": datePrev4.toString(),
                          "idVaccin": idVaccin4,
                        }).then((value) {
                          return true;
                        })
                      : null;
        }
      } else if ((joursEnf > 70) && (joursEnf < 98)) {
        for (var i = 0; i < 2; i++) {
          i == 0
              ? registerCal(data: {
                  "datePrev": datePrev3.toString(),
                  "idVaccin": idVaccin3,
                }).then((value) {
                  return true;
                })
              : i == 1
                  ? registerCal(data: {
                      "datePrev": datePrev4.toString(),
                      "idVaccin": idVaccin4,
                    }).then((value) {
                      return true;
                    })
                  : null;
        }
      } else if ((joursEnf > 98) && (joursEnf < 270)) {
        registerCal(data: {
          "datePrev": datePrev4.toString(),
          "idVaccin": idVaccin4,
        }).then((value) {
          return true;
        });
      }
    });
  }

  Future<bool> initDateCal() async {
    // ignore: await_only_futures
    await findDateAndVacc();

    return false;
  }

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
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "AJOUTER UN ENFANT",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                  fontSize: 20,
                ),
              ),
              SvgPicture.asset(
                "assets/icons/newUser.svg",
                color: kPrimaryColor,
                height: size.height * 0.10,
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
                textInputType: TextInputType.number,
                maxLengt: 3,
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
                  text: "ENREGISTRER",
                  press: () async {
                    // await initDateCal().then((value) {
                    //   value = true;
                    //   if (value) {
                    //     setState(() {
                    //       //vider();
                    //     });
                    //   }
                    // });

                    await initData().then((value) {
                      value = true;
                      if (value) {
                        setState(() {
                          initDateCal();
                          vider();
                        });
                      }
                    });
                    //await initDateCal();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
