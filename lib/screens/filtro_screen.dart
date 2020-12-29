import 'package:flutter_share/flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:mesa_news/models/news_detalhe_model.dart';
import 'package:intl/intl.dart';

class FiltroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filtro"),
        elevation: 0,
        centerTitle: true,
        actions: [
          FlatButton(
              onPressed: () {},
              child: Text(
                "Limpar",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ))
        ],
      ),
      body: Container(),
    );
  }
}
