import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import '../news/news_screen.dart';
import 'package:mesa_news/services/internet_service.dart';
import 'package:mesa_news/services/usuario_service.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'cadastro_screen.dart';
import 'entrar_screen.dart';
import 'package:http/http.dart' as http;

class LoginEmailScreen extends StatefulWidget {
  @override
  _LoginEmailScreenState createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ProgressDialog pr;

  bool isLoggedIn = false;

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
    Navigator.pop(context);

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
    pr = new ProgressDialog(context);

    pr.style(
        message: 'Entrando...',
        borderRadius: 3.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 15.0,
            fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 15.0,
            fontWeight: FontWeight.w600));

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
      pr.show();
      Future.delayed(Duration(seconds: 1)).then((value) {
        pr.hide().whenComplete(() {
          Navigator.pop(context);

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => NewsScreen()));
        });
      });
    }

    void _onFail(success) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Usuário ou senha inválidos"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ));
    }

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Entrar com e-mail"),
          elevation: 0,
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(10.0),
              children: <Widget>[
                Image.asset(
                  'assets/images/login.png',
                  height: 250,
                ),
                TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: "E-mail"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isNotEmpty && !text.contains("@")) {
                        return "E-mail inválido";
                      } else if (text.isEmpty) {
                        return "O campo e-mail é obrigatório";
                      }
                    }),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _senhaController,
                  decoration: InputDecoration(hintText: "Senha"),
                  obscureText: true,
                  validator: (text) {
                    if (text.isEmpty) {
                      return "O campo senha é obrigatório";
                    }
                  },
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  height: 50.0,
                  width: double.infinity,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        InternetService.verificarConexao().then((success) {
                          if (success) {
                            final body = {
                              "email": _emailController.text.trim(),
                              "password": _senhaController.text.trim(),
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
                      }
                    },
                    child: Text('Login', style: TextStyle(color: Colors.white)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  height: 50.0,
                  width: double.infinity,
                  child: RaisedButton(
                    child: Text(
                      'Entrar com facebook',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () => initiateFacebookLogin(),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Não tenho conta. ",
                      style: TextStyle(color: Theme.of(context).primaryColor),
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
            ),
          ),
        ));
  }
}
