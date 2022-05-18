import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:v_connect/Screens/Signup/components/background.dart';
import 'package:v_connect/Screens/Signup/components/utils.dart';
import 'package:v_connect/components/rounded_button.dart';

import '../../../constants.dart';

class BodyCal extends StatefulWidget {
  const BodyCal({Key key}) : super(key: key);

  @override
  _BodyCalState createState() => _BodyCalState();
}

class _BodyCalState extends State<BodyCal> {
  @override
  void initState() {
    super.initState();
  }

  String datePrevue;
  int idVAT, jours, nbreDoses;

  final DateTime dateNow = new DateTime.now();
  DateFormat formatter = new DateFormat('yyyy-MM-dd');
  String dateformatted;
  DateTime selectedDate2 = DateTime.now();
  var dateLastVat = TextEditingController();
  var dateLastVat2 = TextEditingController();

  initDate2() async {
    selectedDate2 = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(2050)));
    if (selectedDate2 != null)
      setState(() {
        dateLastVat2.text = selectedDate2.toString().substring(0, 10);
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
        } else if ((dateNow.difference(selectedDate2).inDays) < 1) {
          datePrevue =
              formatter.format(dateNow.add(Duration(days: (30 - jours))));
        }
        idVAT = 2;
      } else if (nbreDoses == 2) {
        if (dateformatted == dateLastVat.text) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 120)));
        } else if ((dateNow.difference(selectedDate2).inDays) >= 120) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 2)));
        } else if ((dateNow.difference(selectedDate2).inDays) < 1) {
          datePrevue =
              formatter.format(dateNow.add(Duration(days: (120 - jours))));
        }
        idVAT = 3;
      } else if (nbreDoses == 3) {
        if (dateformatted == dateLastVat.text) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 360)));
        } else if ((dateNow.difference(selectedDate2).inDays) >= 360) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 2)));
        } else if ((dateNow.difference(selectedDate2).inDays) < 1) {
          datePrevue =
              formatter.format(dateNow.add(Duration(days: (360 - jours))));
        }
        idVAT = 4;
      } else if (nbreDoses == 4) {
        if (dateformatted == dateLastVat.text) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 360)));
        } else if ((dateNow.difference(selectedDate2).inDays) >= 360) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 2)));
        } else if ((dateNow.difference(selectedDate2).inDays) < 1) {
          datePrevue =
              formatter.format(dateNow.add(Duration(days: (360 - jours))));
        }
        idVAT = 5;
      }
    });
  }

  int indexTop = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Background(
            child: Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            Text(
              "PREPARATION DU CALENDRIER",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown,
                fontSize: 18,
              ),
            ),
            SizedBox(height: size.height * 0.05),
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
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            borderRadius: BorderRadius.circular(29)),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Date derniere dose",
                            icon:
                                Icon(Icons.calendar_today, color: Colors.black),
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
                    RoundedButton(
                      text: "SOUMETTRE",
                      press: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
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
          onChanged: (value) => setState(() => this.indexTop = value.toInt()),
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
}
