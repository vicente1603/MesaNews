import 'package:flutter_share/flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:mesa_news/models/news_detalhe_model.dart';
import 'package:intl/intl.dart';

class DetalhesNewsScreen extends StatelessWidget {
  NewsDetalheModel news;

  DetalhesNewsScreen(this.news);

  @override
  Widget build(BuildContext context) {
    DateTime dataPublicacao = DateTime.parse(news.published_at);
    String formattedDate =
        DateFormat('dd/MM/yyy  kk:mm').format(dataPublicacao);

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
                children: [
                  IconButton(icon: Icon(Icons.star_border), onPressed: () {}),
                  Text(
                    formattedDate,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  Expanded(
                      child: Text(
                    " | Atualizada em ${formattedDate}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ))
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
                      style: TextStyle(color: Colors.black, fontSize: 15))),
              SizedBox(height: 15),
              FlatButton(
                child: IconButton(
                  icon: Icon(
                    Icons.share,
                    color: Theme.of(context).primaryColor,
                    size: 30.0,
                  ),
                ),
                textColor: Colors.white,
                onPressed: () async {
                  await FlutterShare.share(
                    title: news.title,
                    text: news.content,
                    linkUrl: news.url,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
