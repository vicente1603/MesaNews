import 'package:flutter/material.dart';

class CadastroScreen extends StatelessWidget {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmacaoSenhaController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
                      if (text.isNotEmpty) {
                        return "E-mail inválido";
                      } else if (text.isEmpty) {
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
                    if (text.isNotEmpty && text.length < 6) {
                      return "Senha inválida";
                    } else if (text.isEmpty) {
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
                    if (text.isNotEmpty) {
                      return "Confirmação de senha inválida";
                    } else if (text.isEmpty) {
                      return "O campo confirmar senha é obrigatório";
                    }
                  },
                ),
                TextFormField(
                  controller: _dataNascimentoController,
                  decoration: InputDecoration(hintText: "Data de nascimento - opcional"),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  height: 50.0,
                  width: double.infinity,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {},
                    child: Text('Cadastrar', style: TextStyle(color: Colors.white)),
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
