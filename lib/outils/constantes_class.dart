import 'package:flutter/material.dart';

const API_REST = "http://172.20.10.3/vConnectMobile/";
const NAME_APP = "";

class Constantes {
  static String nameHopital;
  static List listHopital = <String>[];
  static List listMereEnfant = <String>[];
  static List listMere = <String>[];
}

Widget cbList(
        {List<DropdownMenuItem<String>> list,
        title,
        String valeur,
        Function onChanged}) =>
    Container(
      width: 262,
      child: DropdownButtonFormField(
        isExpanded: true,
        items: list,
        value: valeur,
        onChanged: onChanged,
        hint: Text(
          "Sélectionnez ${title}",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        ),
        decoration: InputDecoration(
          //labelText: "Technologies",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(29)),
          fillColor: Colors.white, filled: true,
          hintStyle: TextStyle(
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              backgroundColor: Colors.white),
          contentPadding: EdgeInsets.fromLTRB(40, 10, 50, 1),
          //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        validator: (val) => val == null ? "Ce champs est obligatoire" : null,
        onSaved: (val) => valeur = val,
      ),
    );

List<DropdownMenuItem<String>> isList({List<String> value}) {
  return value
      .map(
        (value) => DropdownMenuItem(
          value: value,
          child: value == null || value.isEmpty
              ? Text("")
              : Row(
                  children: [
                    Container(
                      height: 16,
                      width: 16,
                      child: Center(
                        child: Text(
                          value.substring(0, 1).toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    SizedBox(width: 3),
                    Text(
                      value,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
        ),
      )
      .toList();
}
