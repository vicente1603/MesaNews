import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:mesa_news/models/news_detalhe_model.dart';

class DetalhesNewsScreen extends StatelessWidget {
  NewsDetalheModel news;

  DetalhesNewsScreen(this.news);

  @override
  Widget build(BuildContext context) {
    DateTime dataPublicacao = DateTime.parse(news.published_at);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(news.title),
            Text(
              news.url,
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
            Container(
            alignment: Alignment.center,
              child: Image.network(
                news.image_url,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
            IconButton(
            icon: Icon(Icons.star_border), onPressed: () {}),
        Text("${dataPublicacao.day}/${dataPublicacao.month}/${dataPublicacao
            .year}",
        style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold),
      )
      ],
    ),
    SizedBox(height: 10),
    Container(
    alignment: Alignment.center,
    child: Text(news.title,
    textAlign: TextAlign.center,
    style: TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold))),
    SizedBox(height: 15),
    Container(
    child: Text(news.content,
    textAlign: TextAlign.justify,
    style: TextStyle(
    color: Colors.black,
    fontSize: 15
    )))
    ],
    ),
    ),
    ),
    );
  }
}
