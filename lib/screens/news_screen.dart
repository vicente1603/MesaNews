import 'package:flutter/material.dart';
import 'package:mesa_news/models/news_detalhe_model.dart';
import 'package:mesa_news/services/news_service.dart';
import 'package:mesa_news/tiles/news_popular_tile.dart';
import 'package:mesa_news/tiles/news_tile.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'filtro_screen.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<NewsDetalheModel> news = [];
  ScrollController _controller;
  var pagina_atual = 1;
  ProgressDialog pr;

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      pr.show();

      Future.delayed(Duration(seconds: 1)).then((value) {
        pr.hide().whenComplete(() {
          pagina_atual++;

          NewsService.getNews(pagina_atual).then((_news) {
            news.addAll(_news);

            setState(() {});
          });
        });
      });
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);

    pr.style(
        message: 'Carregando notícias...',
        borderRadius: 3.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w600));

    return Scaffold(
      appBar: AppBar(
        title: Text("Mesa News"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                Icons.filter_list_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FiltroScreen()));
              })
        ],
      ),
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
                child: FutureBuilder<List<NewsDetalheModel>>(
                  future: NewsService.getNews(pagina_atual),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (news.length < 10) {
                        news = [];
                        news.addAll(snapshot.data);

                        if (news.length == 0) {
                          return Container(
                            child: Center(
                              child: Text(
                                "Nenhuma notícia cadastrada.",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          );
                        }
                      }

                      return ListView.builder(
                        controller: _controller,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return NewsTile(news[index]);
                        },
                        itemCount: news.length,
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
