import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:v_connect/app/source/updates.dart';
import 'package:v_connect/constants.dart';
import 'package:v_connect/outils/constantes_class.dart';
import 'package:v_connect/outils/outils_app.dart';

class TableMesEnfants extends StatefulWidget {
  final titreTable;
  final List data;
  const TableMesEnfants({Key key, this.titreTable, this.data})
      : super(key: key);

  @override
  _TableMesEnfantsState createState() => _TableMesEnfantsState();
}

class _TableMesEnfantsState extends State<TableMesEnfants> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 550,
      // alignment: Alignment.topRight,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.orangeAccent, width: .5),
        boxShadow: [
          BoxShadow(offset: Offset(0, 6), color: Colors.black, blurRadius: 12)
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(
        bottom: 15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                "Mes enfants",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          DataTable2(
              columnSpacing: 5,
              horizontalMargin: 1,
              columns: [
                DataColumn2(
                  label: Text(
                    "Noms",
                    style: TextStyle(color: kPrimaryColor, fontSize: 15),
                  ),
                  size: ColumnSize.L,
                ),
                DataColumn2(
                  label: Text(
                    'Date Naiss',
                    style: TextStyle(color: kPrimaryColor, fontSize: 15),
                  ),
                  // size: ColumnSize.M,
                ),
                DataColumn2(
                  label: Text(
                    'Sexe',
                    style: TextStyle(color: kPrimaryColor, fontSize: 15),
                  ),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Text(
                    'Action',
                    style: TextStyle(color: kPrimaryColor, fontSize: 15),
                  ),
                  size: ColumnSize.M,
                ),
              ],
              rows: List<DataRow>.generate(widget.data.length, (index) {
                var data = widget.data[index];
                var id = data['idEnfant'];

                TextEditingController nom = new TextEditingController();
                TextEditingController lieu = new TextEditingController();
                TextEditingController poids = new TextEditingController();
                TextEditingController taille = new TextEditingController();
                TextEditingController numCarte = new TextEditingController();
                var dateNaisse = TextEditingController();

                nom.text = data['noms'];
                lieu.text = data['lieuNaiss'];
                poids.text = data['poids'];
                taille.text = data['taille'];
                numCarte.text = data['numCarteVacc'];
                dateNaisse.text = data['dateNaissance'];

                void vider() {
                  id = "";
                  nom.text = "";
                  poids.text = "";
                  taille.text = "";
                  numCarte.text = "";
                  dateNaisse.text = "";
                }

                DateTime selectedDate = DateTime.now();
                String sexe;

                initDate(context) async {
                  selectedDate = (await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1960),
                      lastDate: DateTime(2050)));
                  if (selectedDate != null)
                    dateNaisse.text = selectedDate.toString().substring(0, 10);
                }

                return DataRow(cells: [
                  DataCell(
                    Text(
                      data["noms"],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(
                      data["dateNaissance"],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      data["sexe"],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  DataCell(
                      Container(
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: .5),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: Text(
                          "Modifier",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                      ), onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            scrollable: true,
                            title: Text(
                              'MODIFIER ENFANT',
                              textAlign: TextAlign.center,
                            ),
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Form(
                                child: Container(
                                  width: 400,
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        initialValue: "${id}",
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          labelText: 'Identifiant',
                                          icon: Icon(Icons.account_box),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: nom,
                                        keyboardType: TextInputType.name,
                                        inputFormatters: <TextInputFormatter>[
                                          WhitelistingTextInputFormatter(
                                              RegExp("[a-zA-ZÄäÖöÜü]"))
                                        ],
                                        decoration: InputDecoration(
                                          labelText: 'Noms',
                                          hintText: "Nom complet",
                                          icon: Icon(Icons.account_box),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: lieu,
                                        keyboardType: TextInputType.name,
                                        inputFormatters: <TextInputFormatter>[
                                          WhitelistingTextInputFormatter(
                                              RegExp("[a-zA-ZÄäÖöÜü0-9]"))
                                        ],
                                        decoration: InputDecoration(
                                          labelText: 'Lieu Naissance',
                                          hintText: "Lieu Naissance",
                                          icon: Icon(Icons.place_outlined),
                                        ),
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                          hintText: "Date de naissance",
                                          icon: Icon(
                                            Icons.calendar_today,
                                          ),
                                        ),
                                        controller: dateNaisse,
                                        readOnly: true,
                                        onTap: () {
                                          initDate(context);
                                        },
                                      ),
                                      Container(
                                          child: cbList(
                                              title: "Sexe",
                                              list: isList(value: [
                                                "Féminin",
                                                "Masculin"
                                              ]),
                                              onChanged: (val) {
                                                sexe = val;
                                              })),
                                      TextFormField(
                                        controller: poids,
                                        maxLength: 4,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          WhitelistingTextInputFormatter(
                                              RegExp("[0-9]"))
                                        ],
                                        decoration: InputDecoration(
                                          counterText: '',
                                          labelText: 'Poids (En grammes)',
                                          hintText: "Poids  (En grammes)",
                                          icon: Icon(
                                              Icons.accessibility_new_outlined),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: taille,
                                        maxLength: 3,
                                        inputFormatters: <TextInputFormatter>[
                                          WhitelistingTextInputFormatter(
                                              RegExp("[0-9]"))
                                        ],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          counterText: '',
                                          labelText: 'Taille (En Cm)',
                                          hintText: "Taille (En Cm)",
                                          icon: Icon(Icons.height_sharp),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: numCarte,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          WhitelistingTextInputFormatter(
                                              RegExp("[0-9]"))
                                        ],
                                        decoration: InputDecoration(
                                          labelText: 'Num carte',
                                          hintText: "Numero carte",
                                          icon: Icon(Icons.document_scanner),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            actions: [
                              Container(
                                  child: RaisedButton(
                                child: Text(
                                  "Terminer",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  await DataUpdate.getInstance.modifEnf(data: {
                                    "idEnfant": id,
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
                                    vider();
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content:
                                                Text("Modifié avec succès"),
                                          );
                                        });
                                  });
                                },
                                color: kPrimaryColor,
                              ))
                            ],
                          );
                        });
                  }),
                ]);
              }).toList()),
        ],
      ),
    );
  }

  String sexe;
}
