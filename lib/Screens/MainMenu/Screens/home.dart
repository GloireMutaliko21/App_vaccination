import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:v_connect/app/source/data_source.dart';
import 'package:v_connect/constants.dart';
import 'package:v_connect/outils/constantes_class.dart';
import 'package:v_connect/outils/outils_app.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback login;
  const HomeScreen({
    Key key,
    this.login,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();
    getEnf();
  }

  bool isLoad = false;
  Future<void> getEnf() async {
    await DataSource.getInstance.getEnfant(params: {
      "event": "FIND_ENFANT_CAL_ACTIF",
      "idMere": MyPreferences.idMere
    }).then((value) {
      //showNotification();
      setState(() {
        Constantes.listMereEnfant = value;
        isLoad = true;
      });
    });
  }

  Future<void> getMere() async {
    await DataSource.getInstance.getEnfant(params: {
      "event": "FIND_MERE",
      "idMere": MyPreferences.idMere
    }).then((value) {
      setState(() {
        if (value.lenght > 0) {
          Constantes.listMere = value;
        }
        // Constantes.listMere = value;
      });
    });
  }

  int itemCount = Constantes.listMereEnfant.length;

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(210, 220, 240, 240),
              // image: DecorationImage(
              //     image: AssetImage("assets/images/BackV.png"),
              //     fit: BoxFit.cover),
            ),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              itemCount: itemCount,
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
                            //initDonnee();
                          });
                        },
                        minVerticalPadding: 8,
                        contentPadding: EdgeInsets.symmetric(horizontal: 6.0),
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
                                "Programme de vaccination",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Attendu le ${Constantes.listMereEnfant[i]['datePrev']} pour le vaccin",
                                style: TextStyle(
                                    color: Colors.amber.shade300,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                              Text(
                                "${Constantes.listMereEnfant[i]['jour']} jours restants",
                                style: TextStyle(
                                    color: Colors.lime.shade500,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
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
            )));
  }
}
