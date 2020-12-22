import 'package:flutter/material.dart';

import 'cadastro_screen.dart';
import 'login_email_screen.dart';

class EntrarScreen extends StatelessWidget {
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
                    onPressed: () {},
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
