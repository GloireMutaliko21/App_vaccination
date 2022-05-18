import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:v_connect/outils/constantes_class.dart';

class DataUpdate {
  static DataUpdate _instance = DataUpdate();

  static DataUpdate get getInstance {
    return _instance == null ? _instance = DataUpdate() : _instance;
  }

//==============================================================================
//==============================================================================
//++++++++++++++++++++++ MODIFIER L'ENFANT++++++++++++++++++++++++++++++

  Future<String> modifEnf({var data}) async {
    try {
      final response = await http.post(Uri.parse("${API_REST}ModifEnf.php"),
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        var resultat = await jsonDecode(response.body);
        resultat.forEach((data) => {print(data)});
      } else {}
    } catch (_) {
      print("=======================${_.toString()}");
    }
    return null;
  }
}
