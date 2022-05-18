import 'package:flutter/material.dart';
import 'package:v_connect/Screens/MainMenu/Screens/Enfants/Table/table.dart';
import 'package:v_connect/Screens/MainMenu/Screens/Enfants/enregistrer_screen.dart';
import 'package:v_connect/Screens/MainMenu/Screens/table.dart';
import 'package:v_connect/app/source/data_source.dart';
import 'package:v_connect/constants.dart';
import 'package:v_connect/outils/outils_app.dart';

class MesEnfatsTb extends StatefulWidget {
  const MesEnfatsTb({Key key}) : super(key: key);

  @override
  _MesEnfatsTbState createState() => _MesEnfatsTbState();
}

class _MesEnfatsTbState extends State<MesEnfatsTb> {
  List agent = <dynamic>[];
  Future<void> getIdentif() async {
    await DataSource.getInstance.getEnfant(params: {
      "event": "FIND_ENFANT_ONLY",
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
                        child: TableMesEnfants(
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
      ),
    );
  }
}
