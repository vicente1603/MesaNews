import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mesa_news/models/news_detalhe_model.dart';
import 'package:mesa_news/models/news_model.dart';
import 'package:mesa_news/models/paginacao_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsService {
  static Future<List<NewsDetalheModel>> getNews(pagina_atual) async {
    var prefs = await SharedPreferences.getInstance();

    String token = (prefs.getString("token") ?? "");

    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}"
    };



    final response = await http.get(
        'https://mesa-news-api.herokuapp.com/v1/client/news?current_page=${pagina_atual}&per_page=10&published_at=',
        headers: header);

    if (response.statusCode == 200) {
      Map data = json.decode(response.body);

      NewsModel news = new NewsModel.fromJson(data);

      final newsDetalhes = (data["data"] as List)
          .map((i) => new NewsDetalheModel.fromJson(i))
          .toList();

      final paginacao = new PaginacaoModel.fromJson(data["pagination"]);

      news.data = newsDetalhes;
      news.pagination = paginacao;

      return news.data;
    } else {
      return null;
    }
  }

  static Future<List<NewsDetalheModel>> getPopularNews() async {
    var prefs = await SharedPreferences.getInstance();

    String token = (prefs.getString("token") ?? "");

    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}"
    };

    final response = await http.get(
        'https://mesa-news-api.herokuapp.com/v1/client/news/highlights',
        headers: header);

    if (response.statusCode == 200) {
      Map data = json.decode(response.body);


      final newsPopularDetalhes = (data["data"] as List)
          .map((i) => new NewsDetalheModel.fromJson(i))
          .toList();

      return newsPopularDetalhes;
    } else {
      return null;
    }
  }
}
