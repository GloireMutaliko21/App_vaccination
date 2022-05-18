import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:v_connect/constants.dart';

class TableData extends StatefulWidget {
  final titreTable;
  final List data;
  const TableData({Key key, this.titreTable, this.data}) : super(key: key);

  @override
  _TableDataState createState() => _TableDataState();
}

class _TableDataState extends State<TableData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 550,
      // alignment: Alignment.topRight,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: kPrimaryColor, width: 1),
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
                "Calendriers en cours de mes enfants",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          DataTable2(
              columnSpacing: 5,
              horizontalMargin: 5,
              columns: [
                DataColumn2(
                  label: Text(
                    "Noms",
                    style: TextStyle(color: kPrimaryColor, fontSize: 18),
                  ),
                  size: ColumnSize.L,
                ),
                DataColumn2(
                  label: Text(
                    'Date',
                    style: TextStyle(color: kPrimaryColor, fontSize: 18),
                  ),
                  size: ColumnSize.M,
                ),
                DataColumn2(
                  label: Text(
                    'vaccin',
                    style: TextStyle(color: kPrimaryColor, fontSize: 18),
                  ),
                  size: ColumnSize.S,
                ),
              ],
              rows: List<DataRow>.generate(widget.data.length, (index) {
                var data = widget.data[index];

                return DataRow(cells: [
                  DataCell(
                    Text(
                      "${data["nom"]}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(
                      data["datePrev"],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      data["nomVaccin"],
                      style: TextStyle(
                        color: Colors.red.shade900,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ]);
              }).toList()),
        ],
      ),
    );
  }

  String sexe;
}
