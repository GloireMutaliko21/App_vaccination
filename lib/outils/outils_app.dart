// [{"idMere":"4","0":"4","noms":"Gloire Mutaliko","1":"Gloire Mutaliko","dateNaiss":"1997-07-24","2":"1997-07-24","tel":"0670987018","3":"0670987018","adresse":"Texas","4":"Texas","loginM":"salva","5":"salva","pwM":"ssss","6":"ssss","idHopital":"1","7":"1"}]

import 'package:shared_preferences/shared_preferences.dart';

class MyPreferences {
  static MyPreferences _myPreferences;

  static String idMere;
  static String noms;
  static String idHopital;

  static MyPreferences get getInit {
    return _myPreferences == null
        ? _myPreferences = MyPreferences()
        : _myPreferences;
  }

  Future<bool> setPresistence(var data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("idMere", data[0]['idMere']);
    preferences.setString("noms", data[0]['noms']);
    return preferences.setString("idHopital", data[0]['idHopital']);
  }

  Future<void> getPresistence() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idMere = preferences.getString("idMere");
    noms = preferences.getString("noms");
    idHopital = preferences.getString("idHopital");
  }
}

class MyPreferencesEnfant {
  static MyPreferencesEnfant _myPreferences;

  static String idEnfant;
  static String noms;
  static String dateNaissance;
  static String poids;
  static String taille;
  static String carte;

  static MyPreferencesEnfant get getInit {
    return _myPreferences == null
        ? _myPreferences = MyPreferencesEnfant()
        : _myPreferences;
  }

  Future<bool> setPersistence(var data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("idEnfant", data[0]['idEnfant']);
    preferences.setString("noms", data[0]['noms']);
    preferences.setString("dateNaissance", data[0]['dateNaissance']);
    preferences.setString("poids", data[0]['poids']);
    preferences.setString("taille", data[0]['taille']);
    return preferences.setString("carte", data[0]['carte']);
  }

  Future<void> getPersistence() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idEnfant = preferences.getString("idEnfant");
    noms = preferences.getString("noms");
    dateNaissance = preferences.getString("dateNaissance");
    poids = preferences.getString("poids");
    taille = preferences.getString("taille");
    carte = preferences.getString("carte");
  }
}
