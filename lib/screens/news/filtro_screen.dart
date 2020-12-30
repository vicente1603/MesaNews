import 'package:flutter/material.dart';
import 'package:mesa_news/models/news_detalhe_model.dart';
import 'package:mesa_news/services/news_service.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'favoritos_screen.dart';

class FiltroScreen extends StatefulWidget {
  @override
  _FiltroScreenState createState() => _FiltroScreenState();
}

class _FiltroScreenState extends State<FiltroScreen> {
  NewsDetalheModel newsSelecionada;
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filtro"),
        elevation: 0,
        centerTitle: true,
        actions: [
          FlatButton(
              onPressed: () {
                setState(() {
                  isSwitched = false;
                  newsSelecionada = null;
                });
              },
              child: Text(
                "Limpar",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // FutureBuilder<List<NewsDetalheModel>>(
            //   future: NewsService.getNews(1),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       timeago.setLocaleMessages('pt_BR', timeago.PtBrMessages());
            //       return DropdownButton<NewsDetalheModel>(
            //         items: snapshot.data
            //             .map((news) => DropdownMenuItem<NewsDetalheModel>(
            //                   child: Text(timeago.format(
            //                       DateTime.parse(news.published_at),
            //                       locale: 'pt_BR')),
            //                   value: news,
            //                 ))
            //             .toList(),
            //         onChanged: (NewsDetalheModel value) {
            //           setState(() {
            //             newsSelecionada = value;
            //           });
            //         },
            //         isExpanded: true,
            //         //value: _currentUser,
            //         hint: newsSelecionada != null
            //             ? Text(timeago.format(
            //                 DateTime.parse(newsSelecionada.published_at),
            //                 locale: 'pt_BR'))
            //             : Text("SELECIONE"),
            //       );
            //     } else {
            //       return Center(child: CircularProgressIndicator());
            //     }
            //   },
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Apenas favoritos",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      print(isSwitched);
                    });
                  },
                  activeTrackColor: Colors.blue,
                  activeColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                width: double.infinity,
                child: FlatButton(
                  child: Text('Filtrar', style: TextStyle(fontSize: 20)),
                  onPressed: isSwitched == false && newsSelecionada == null
                      ? null
                      : () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FavoritosScreen()));
                  },
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
