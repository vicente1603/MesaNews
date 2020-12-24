import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mesa_news/models/news_detalhe_model.dart';

class NewsPopularTile extends StatelessWidget {
  final NewsDetalheModel news;

  NewsPopularTile(this.news);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 24),
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(6),
                  bottomLeft: Radius.circular(6))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        news.image_url,
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(width: 10),
                  Expanded(
                      child: Text(
                    news.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
