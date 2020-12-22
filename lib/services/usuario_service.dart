import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioService {
  static var token;

  static Future<bool> autenticar(body) async {
    final response = await http.post(
        'https://mesa-news-api.herokuapp.com/v1/client/auth/signin',
        body: body);

    if (response.statusCode == 200) {
      var prefs = await SharedPreferences.getInstance();

      token = jsonDecode(response.body);

      prefs.setString("token", token["token"]);

      return true;
    } else {
      return false;
    }
  }

// static Future<String> cadastrar(body) async {
//   final response =
//   await http.post('${URLS.PORTALCIDADAO}/Usuarios/Cadastrar', body: body);
//
//   var mensagem;
//
//   if (response.statusCode == 200) {
//     mensagem = response.body;
//     return mensagem;
//   } else {
//     mensagem = json.decode(response.body);
//     mensagem = mensagem[0];
//     return mensagem;
//   }
// }

}
