import 'package:flutter/material.dart';
import 'package:mesa_news/models/news_detalhe_model.dart';
import 'package:mesa_news/models/news_model.dart';
import 'package:mesa_news/services/news_service.dart';
import 'package:mesa_news/tiles/news_popular_tile.dart';
import 'package:mesa_news/tiles/news_tile.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mesa News"), centerTitle: true),
      body: Container(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      "Destaques",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                )),
            Container(
                height: 175,
                child: FutureBuilder<List<NewsDetalheModel>>(
                  future: NewsService.getPopularNews(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return NewsPopularTile(snapshot.data[index]);
                        },
                        itemCount: snapshot.data.length,
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                )),
            Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      "Últimas notícias",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                )),
            Expanded(
                flex: 1,
                child: FutureBuilder<NewsModel>(
                  future: NewsService.getNews(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return NewsTile(snapshot.data.data[index]);
                        },
                        itemCount: snapshot.data.data.length,
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
