import 'package:flutter/material.dart';
import 'package:mesa_news/models/news_model.dart';
import 'package:mesa_news/services/news_service.dart';
import 'package:mesa_news/tiles/news_tile.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mesa News"), centerTitle: true),
      body: Container(
        child: FutureBuilder<NewsModel>(
          future: NewsService.getNews(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(height: 2, color: Colors.black);
                },
                itemBuilder: (context, index) {
                  return NewsTile(snapshot.data.data[index]);
                },
                itemCount: snapshot.data.data.length,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }}
