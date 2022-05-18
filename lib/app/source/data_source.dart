import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:v_connect/constants.dart';
import 'package:v_connect/outils/constantes_class.dart';

class DataSource {
  static DataSource _instance;
//Maintenant on peu cree une variable qui recevoir l'url qui va comque avec le serveur externe
//exemple

//vous etes deja sur la version 2.2.1 flutter  c' pourquoi ca demant Uri
  var urlDistant = ("https://vconnectapp.000webhostapp.com/vConnectMobile/");
  var fichier;

  static DataSource get getInstance {
    return _instance == null ? _instance = DataSource() : _instance;
  }

  //Ex sur la methode POST
  //vu que sa va utiliser la methode asynchrone on va ajoute le mot cle async
  Future<bool> sendData({var elements}) async {
    try {
      var data = {/*Ici on ajouter tous qui est parametre*/};
      final response =
          await http.post(Uri.parse("${urlDistant}fichier.php"), body: data);
      var resultat = await jsonDecode(response.body);
      if (resultat == "Ex save") {
        return true;
      }
    } catch (_) {
      print(_.toString());
    }
    return false;
  }

  Future<List<String>> getList({Map<String, dynamic> params, donne}) async {
    List element = <String>[];
    final response =
        await http.post(Uri.parse("${API_REST}selectHop.php"), body: params);
    var resultat = await jsonDecode(response.body);
    for (int index = 0; index < resultat.length; index++) {
      element.add(resultat[index][donne]);
    }
    print(resultat);
    return element;
  }

  getEnfant({Map<dynamic, String> params}) async {
    try {
      final response =
          await http.post(Uri.parse("${API_REST}selectHop.php"), body: params);
      var resultat = await jsonDecode(response.body);
      return resultat;
    } on SocketException catch (e) {
      SnackBar(
        content: Text(
          "Echec de connexion ${e.toString()}",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        backgroundColor: kPrimaryColor,
      );
    }
  }

  insert({Map<dynamic, String> params}) async {
    final response = await http.post(Uri.parse("${API_REST}selectHop.php"),
        body: jsonEncode(params));
    var resultat = await jsonDecode(response.body);
    return resultat;
  }
}
