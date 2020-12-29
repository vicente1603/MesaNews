import 'dart:async';
import 'dart:convert';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:mesa_news/models/news_detalhe_model.dart';
import 'package:mesa_news/models/news_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritosBloc implements BlocBase {
  Map<String, NewsDetalheModel> _favoritos = {};

  final _favController =
  BehaviorSubject<Map<String, NewsDetalheModel>>(seedValue: {});

  Stream<Map<String, NewsDetalheModel>> get outFav => _favController.stream;

  FavoriteBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains("favorites")) {
        _favoritos = json.decode(prefs.getString("favorites")).map((k, v) {
          return MapEntry(k, NewsModel.fromJson(v));
        }).cast<String, NewsDetalheModel>();
        _favController.add(_favoritos);
      }
    });
  }

  void toggleFavorite(NewsDetalheModel news) {
    if (_favoritos.containsKey(news.title))
      _favoritos.remove(news.title);
    else
      _favoritos[news.title] = news;

    _favController.sink.add(_favoritos);
    _saveFav();
  }

  void _saveFav() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("favoritos", json.encode(_favoritos));
    });
  }

  @override
  void dispose() {
    _favController.close();
  }
}
