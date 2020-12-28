import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mesa_news/models/news_detalhe_model.dart';
import 'package:mesa_news/screens/detalhes_news_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsPopularTile extends StatelessWidget {
  final NewsDetalheModel news;

  NewsPopularTile(this.news);

  @override
  Widget build(BuildContext context) {
    DateTime dataPublicacao = DateTime.parse(news.published_at);
    timeago.setLocaleMessages('pt_BR', timeago.PtBrMessages());

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DetalhesNewsScreen(news)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(6),
                  bottomLeft: Radius.circular(6))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    news.image_url,
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  )),
              Padding(padding: EdgeInsets.only(left: 16.0)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      news.title,
                      maxLines: 3,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            icon: Icon(Icons.star_border), onPressed: () {}),
                        Text(
                          timeago.format(dataPublicacao, locale: 'pt_BR'),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
