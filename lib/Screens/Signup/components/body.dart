import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:v_connect/Screens/Login/login_screen.dart';
import 'package:v_connect/Screens/Signup/components/background.dart';
import 'package:v_connect/Screens/Signup/components/utils.dart';
import 'package:v_connect/app/source/data_source.dart';
import 'package:v_connect/components/already_have_an_account_acheck.dart';
import 'package:v_connect/components/rounded_button.dart';
import 'package:v_connect/components/rounded_input_field.dart';
import 'package:v_connect/components/rounded_password_field.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:v_connect/outils/constantes_class.dart';
import '../../../constants.dart';

class Body extends StatefulWidget {
  final Widget child;

  const Body({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

//
class _BodyState extends State<Body> {
  var dateNaisse = TextEditingController();
  DateTime selectedDate = DateTime.now();
  void initState() {
    super.initState();
    getHopital();
  }

  String datePrevue;
  int idVAT, jours, nbreDoses = 0;

  final DateTime dateNow = new DateTime.now();
  DateFormat formatter = new DateFormat('yyyy-MM-dd');
  String dateformatted;
  DateTime selectedDate2 = DateTime.now();
  var dateLastVat = TextEditingController();

  Future<void> getHopital() async {
    await DataSource.getInstance.getList(
        params: {"event": "FIND_HOPITAL"}, donne: "hopital").then((value) {
      setState(() {
        Constantes.listHopital = value;
      });
    });
  }

  Future<String> register({var data}) async {
    try {
      final response = await http.post(Uri.parse("${API_REST}Enregistrer.php"),
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        print(nbreDoses);
        if (nbreDoses < 5) {
          var resultat = await jsonDecode(response.body);
          resultat.forEach((data) => {print(data)});
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Vous êtes completement vaccinée",
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
      print("=======================${_.toString()}");
    }
    return null;
  }

  TextEditingController nom = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController numT = new TextEditingController();
  TextEditingController adress = new TextEditingController();
  TextEditingController log = new TextEditingController();
  TextEditingController pw = new TextEditingController();
  TextEditingController pw2 = new TextEditingController();
  String idHop;

  void vider() {
    nom.clear();
    date.text = "";
    numT.clear();
    adress.clear();
    log.clear();
    pw.clear();
    pw2.clear();
  }

  String val = "";
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

  int indexTop = 0;

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
                "S'ENREGISTRER",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                  fontSize: 20,
                ),
              ),
              SvgPicture.asset(
                "assets/icons/user.svg",
                color: kPrimaryColor,
                height: size.height * 0.15,
              ),
              RoundedInputField(
                controller: nom,
                hintText: "Nom complet",
                icon: Icons.admin_panel_settings_outlined,
                onChanged: (value) {},
                textInputType: TextInputType.name,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter(RegExp("[a-zA-ZÄäÖöÜü]"))
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
              RoundedInputField(
                controller: numT,
                maxLengt: 20,
                hintText: "Numéro téléphone",
                icon: Icons.phone_rounded,
                onChanged: (value) {},
                textInputType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter(RegExp("[0-9+ ]"))
                ],
              ),
              RoundedInputField(
                controller: adress,
                hintText: "Adresse locale",
                icon: Icons.home_work_rounded,
                onChanged: (value) {},
                textInputType: TextInputType.streetAddress,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter(RegExp("[a-zA-ZÄäÖöÜü0-9]"))
                ],
              ),
              RoundedInputField(
                controller: log,
                hintText: "Votre login",
                icon: Icons.person,
                onChanged: (value) {},
                textInputType: TextInputType.text,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter(RegExp("[a-zA-ZÄäÖöÜü0-9]"))
                ],
              ),
              RoundedPasswordField(
                controller: pw,
                onChanged: (value) {},
                hint: "Mot de passe",
              ),
              RoundedPasswordField(
                controller: pw2,
                onChanged: (value) {},
                hint: "Confirmer mot de passe",
              ),
              Container(
                  child: cbList(
                      title: "Hopital",
                      list: isList(value: Constantes.listHopital),
                      onChanged: (val) {
                        setState(() {
                          idHop = val;
                        });
                      })),
              SizedBox(height: size.height * 0.08),
              Text(
                "PREPARATION DU CALENDRIER",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade900,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: size.height * 0.06),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                color: Colors.grey.shade600,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Divider(
                        color: Colors.black,
                      ),
                      Text("Combien de doses avez-vous déjà réçu ?",
                          style: TextStyle(
                            color: Colors.lime.shade500,
                            fontSize: 14,
                          )),
                      SizedBox(height: 8),
                      buildSliderTopLabel(),
                      Divider(
                        color: Colors.black,
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        """
    Ne sélectionner la date que si vous avez déjà réçu une ou plusieurs doses""",
                        style: TextStyle(
                          color: Colors.lime.shade500,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: size.height * 0.02),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 2),
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: kPrimaryLightColor,
                                  borderRadius: BorderRadius.circular(29)),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Date derniere dose",
                                  icon: Icon(Icons.calendar_today,
                                      color: Colors.black),
                                ),
                                controller: dateLastVat,
                                readOnly: true,
                                onTap: () {
                                  setState(() {
                                    initDate2();
                                  });
                                },
                              ),
                            ),
                          ]),
                      Divider(
                        color: Colors.black,
                      ),
                      SizedBox(height: size.height * 0.02),
                    ],
                  ),
                ),
              ),
              RoundedButton(
                text: "S'ENREGISTRER",
                press: () {
                  if (pw.value.text == pw2.value.text) {
                    setState(() {
                      initData();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          nbreDoses > 4
                              ? """
Enregistré avec succès et complètement vaccinée"""
                              : "Enregistré avec succès",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.transparent,
                      ));
                      //vider();
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        nbreDoses < 5
                            ? "Les mots de passe ne correspondent pas"
                            : "Vous êtes completement vaccinée",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: Colors.transparent,
                    ));
                  }
                },
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
              SizedBox(
                height: size.height * 0.07,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void initData() async {
    // ignore: await_only_futures
    await findDateAndVacc();
    await register(data: {
      "noms": nom.text,
      "dateNaiss": dateNaisse.text,
      "tel": numT.text,
      "adresse": adress.text,
      "loginM": log.text,
      "pwM": pw2.text,
      "idHopital": idHop.substring(0, 1),
      "datePrevue": datePrevue,
      "idVAT": idVAT
    }).then((value) {
      print(value);
    });
  }

  Widget buildSliderTopLabel() {
    final labels = ['0', '1', '2', '3', '4', '5'];
    final double min = 0;
    final double max = labels.length - 1.0;
    final divisions = labels.length - 1;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: Utils.modelBuilder(
              labels,
              (index, label) {
                final selectedColor = Colors.indigo.shade900;
                final unselectedColor = Colors.indigo.withOpacity(0.6);
                final isSelected = index <= indexTop;
                final color = isSelected ? selectedColor : unselectedColor;

                return buildLabel(label: label, color: color, width: 30);
              },
            ),
          ),
        ),
        Slider(
          value: indexTop.toDouble(),
          min: min,
          max: max,
          divisions: divisions,
          // label: labels[indexTop],
          onChanged: (value) => setState(() {
            this.indexTop = value.toInt();
            this.nbreDoses = indexTop;
          }),
        ),
      ],
    );
  }

  Widget buildLabel({
    @required String label,
    @required double width,
    @required Color color,
  }) =>
      Container(
        width: width,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ).copyWith(color: color),
        ),
      );

  initDate2() async {
    selectedDate2 = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(2050)));
    if (selectedDate2 != null)
      setState(() {
        dateLastVat.text = selectedDate2.toString().substring(0, 10);
      });
  }

  void findDateAndVacc() {
    setState(() {
      jours = dateNow.difference(selectedDate2).inDays;
      dateformatted = formatter.format(dateNow);
      print(jours);

      if (nbreDoses == 0) {
        datePrevue = formatter.format(dateNow.add(const Duration(days: 2)));
        idVAT = 1;
      } else if (nbreDoses == 1) {
        if (dateformatted == dateLastVat.text) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 30)));
        } else if ((dateNow.difference(selectedDate2).inDays) >= 30) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 2)));
        } else if ((selectedDate2.difference(dateNow).inDays) < 1) {
          datePrevue =
              formatter.format(dateNow.add(Duration(days: (30 - jours))));
        }
        idVAT = 2;
      } else if (nbreDoses == 2) {
        if (dateformatted == dateLastVat.text) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 180)));
        } else if ((dateNow.difference(selectedDate2).inDays) >= 180) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 2)));
        } else if ((selectedDate2.difference(dateNow).inDays) < 1) {
          datePrevue =
              formatter.format(dateNow.add(Duration(days: (180 - jours))));
        }
        idVAT = 3;
      } else if (nbreDoses == 3) {
        if (dateformatted == dateLastVat.text) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 365)));
        } else if ((dateNow.difference(selectedDate2).inDays) >= 365) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 2)));
        } else if ((selectedDate2.difference(dateNow).inDays) < 1) {
          datePrevue =
              formatter.format(dateNow.add(Duration(days: (365 - jours))));
        }
        idVAT = 4;
      } else if (nbreDoses == 4) {
        if (dateformatted == dateLastVat.text) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 365)));
        } else if ((dateNow.difference(selectedDate2).inDays) >= 365) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 2)));
        } else if ((selectedDate2.difference(dateNow).inDays) < 1) {
          datePrevue =
              formatter.format(dateNow.add(Duration(days: (365 - jours))));
        }
        idVAT = 5;
      }
    });
  }
}
