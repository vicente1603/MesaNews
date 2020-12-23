import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../services/internet_service.dart';
import '../services/usuario_service.dart';
import 'entrar_screen.dart';

class CadastroScreen extends StatelessWidget {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmacaoSenhaController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);

    pr.style(
        message: 'Cadastrando...',
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
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("OK"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ));

          // Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(builder: (context) => EntrarScreen()));
        });
      });
    }

    void _onFail(success) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Falha ao cadastrar usuário"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ));
    }

    bool validarSenha() {
      if (_senhaController.text.trim() ==
          _confirmacaoSenhaController.text.trim()) {
        return true;
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("As senhas são diferentes"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        ));
        return false;
      }
    }

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Cadastrar"),
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
                TextFormField(
                    controller: _nomeController,
                    decoration: InputDecoration(hintText: "Nome"),
                    keyboardType: TextInputType.text,
                    validator: (text) {
                      if (text.isEmpty) {
                        return "O campo nome é obrigatório";
                      }
                    }),
                SizedBox(height: 16.0),
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
                TextFormField(
                  controller: _confirmacaoSenhaController,
                  decoration: InputDecoration(hintText: "Confirmar Senha"),
                  obscureText: true,
                  validator: (text) {
                    if (text.isEmpty) {
                      return "O campo confirmar senha é obrigatório";
                    }
                  },
                ),
                TextFormField(
                  controller: _dataNascimentoController,
                  decoration: InputDecoration(
                      hintText: "Data de nascimento - opcional"),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  height: 50.0,
                  width: double.infinity,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState.validate() && validarSenha()) {
                        InternetService.verificarConexao().then((success) {
                          if (success) {
                            final body = {
                              "name": _nomeController.text.trim(),
                              "email": _emailController.text.trim(),
                              "password": _senhaController.text.trim(),
                            };
                            UsuarioService.cadastrar(body).then((success) {
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
                    child: Text('Cadastrar',
                        style: TextStyle(color: Colors.white)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
