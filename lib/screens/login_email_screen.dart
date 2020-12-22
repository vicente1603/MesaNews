import 'package:flutter/material.dart';
import 'package:mesa_news/screens/cadastro_screen.dart';

class LoginEmailScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
                    if (text.isNotEmpty && text.length < 6) {
                      return "Senha inválida";
                    } else if (text.isEmpty) {
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginEmailScreen()));
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
                    onPressed: () {},
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
