import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mesa_news/models/news_detalhe_model.dart';

class NewsTile extends StatelessWidget {
  final NewsDetalheModel news;

  NewsTile(this.news);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      contentPadding: EdgeInsets.all(16),
      title: Text(
        news.title,
        textAlign: TextAlign.justify,
      ),
      subtitle: Text(
        news.description,
        textAlign: TextAlign.justify,
      ),
      onTap: () {},
    );
  }
}
