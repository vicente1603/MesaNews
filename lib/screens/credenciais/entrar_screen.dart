import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:mesa_news/services/internet_service.dart';
import 'package:http/http.dart' as http;
import 'package:mesa_news/services/usuario_service.dart';
import '../news/news_screen.dart';
import 'cadastro_screen.dart';
import 'login_email_screen.dart';

class EntrarScreen extends StatefulWidget {
  @override
  _EntrarScreenState createState() => _EntrarScreenState();
}

class _EntrarScreenState extends State<EntrarScreen> {
  bool isLoggedIn = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
    await facebookLogin.logInWithReadPermissions(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        final token = facebookLoginResult.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = jsonDecode(graphResponse.body);
        print(profile);
        InternetService.verificarConexao().then((success) {
          if (success) {
            final body = {
              "email": profile["email"],
              "password": profile["id"],
            };
            UsuarioService.autenticar(body).then((success) {
              if (success) {
                _onSuccess();
              } else {
                _onFail(success);
              }
            });
          } else {
            _mostrarDialogSemConexao();
          }
        });
        print("LoggedIn");
        onLoginStatusChanged(true);
        break;
    }
  }

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  _mostrarDialogSemConexao() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Ocorreu um erro"),
            content: Text("Você não está conectado com a internet."),
            actions: <Widget>[
              FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop(MaterialPageRoute(
                        builder: (context) => EntrarScreen()));
                  })
            ],
          );
        });
  }

  void _onSuccess() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => NewsScreen()));
  }

  void _onFail(success) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Usuário ou senha inválidos"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/entrar_logo.png"),
                SizedBox(height: 35.0),
                Text(
                  'NEWS',
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 20.0,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                SizedBox(height: 35.0),
                Center(
                    child: SizedBox(
                  height: 50.0,
                  width: double.infinity,
                  child: RaisedButton(
                    child: const Text(
                      'Entrar com facebook',
                      style: TextStyle(color: Colors.blue),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.white,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () => initiateFacebookLogin(),
                  ),
                )),
                SizedBox(height: 15.0),
                Center(
                    child: SizedBox(
                  height: 50.0,
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.transparent,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginEmailScreen()));
                    },
                    child: Text('Entrar com e-mail',
                        style: TextStyle(color: Colors.white)),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.white,
                            width: 2,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                )),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Não tenho conta. ",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CadastroScreen()));
                      },
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ],
            )));
  }
}
