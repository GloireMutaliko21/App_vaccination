import 'package:flutter/material.dart';
import 'package:v_connect/app/source/data_source.dart';
import 'package:v_connect/constants.dart';
import 'package:v_connect/outils/constantes_class.dart';
import 'package:v_connect/outils/outils_app.dart';

class CompteMereScreen extends StatefulWidget {
  const CompteMereScreen({Key key}) : super(key: key);

  @override
  _CompteMereScreenState createState() => _CompteMereScreenState();
}

class _CompteMereScreenState extends State<CompteMereScreen> {
  void initState() {
    super.initState();
    getMere();
  }

  Future<void> getMere() async {
    await DataSource.getInstance.getEnfant(params: {
      "event": "FIND_MERE",
      "idMere": MyPreferences.idMere
    }).then((value) {
      setState(() {
        Constantes.listMere = value;
        print(Constantes.listMere);
      });
    });
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
              getMere();
            },
            icon: Icon(Icons.refresh, color: kPrimaryColor),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(210, 220, 240, 240),
          // image: DecorationImage(
          //     // image: AssetImage("assets/images/BackV.png"), fit: BoxFit.cover),
        ),
        child: Center(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            itemCount: Constantes.listMere.length,
            itemBuilder: (context, i) {
              return Container(
                color: Colors.grey,
                child: Column(
                  children: [
                    ListTile(
                      minVerticalPadding: 8,
                      contentPadding: EdgeInsets.symmetric(horizontal: 6.0),
                      leading: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      title: Text(
                        "Nom complet :",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.brown.shade700,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                      subtitle: Text(
                        Constantes.listMere[i]['noms'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      minVerticalPadding: 8,
                      contentPadding: EdgeInsets.symmetric(horizontal: 6.0),
                      leading: Icon(
                        Icons.calendar_today,
                        color: Colors.blue,
                      ),
                      title: Text(
                        "Date de Naissance :",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.brown.shade700,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                      subtitle: Text(
                        Constantes.listMere[i]['dateNaiss'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      minVerticalPadding: 8,
                      contentPadding: EdgeInsets.symmetric(horizontal: 6.0),
                      leading: Icon(
                        Icons.phone,
                        color: Colors.blue,
                      ),
                      title: Text(
                        "N° Téléphone :",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.brown.shade700,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                      subtitle: Text(
                        Constantes.listMere[i]['tel'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      minVerticalPadding: 8,
                      contentPadding: EdgeInsets.symmetric(horizontal: 6.0),
                      leading: Icon(
                        Icons.home,
                        color: Colors.blue,
                      ),
                      title: Text(
                        "Résidence :",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.brown.shade700,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                      subtitle: Text(
                        Constantes.listMere[i]['adresse'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      minVerticalPadding: 8,
                      contentPadding: EdgeInsets.symmetric(horizontal: 6.0),
                      leading: Icon(
                        Icons.person_pin_circle_outlined,
                        color: Colors.blue,
                      ),
                      title: Text(
                        "Nom d'utilisateur :",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.brown.shade700,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                      subtitle: Text(
                        Constantes.listMere[i]['loginM'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
