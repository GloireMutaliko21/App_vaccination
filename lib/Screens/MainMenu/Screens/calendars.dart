import 'package:flutter/material.dart';
import 'package:v_connect/Screens/MainMenu/Screens/table.dart';
import 'package:v_connect/app/source/data_source.dart';
import 'package:v_connect/outils/outils_app.dart';

class Calendriers extends StatefulWidget {
  const Calendriers({Key key}) : super(key: key);

  @override
  _CalendriersState createState() => _CalendriersState();
}

class _CalendriersState extends State<Calendriers> {
  List agent = <dynamic>[];
  Future<void> getIdentif() async {
    await DataSource.getInstance.getEnfant(params: {
      "event": "CALENDARS",
      "idMere": MyPreferences.idMere
    }).then((value) {
      setState(() {
        agent = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getIdentif();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                    // height: 300,
                    child: SingleChildScrollView(
                        child: TableData(
                  data: agent,
                ))),
                SizedBox(
                  height: 10,
                ),
                // LabelGestion(
                //   label: "Gestion des VATs",
                //   message: "Nouveau VAT",
                //   onPress: () {
                //     _showDialogVAT(context);
                //   },
                // ),
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
