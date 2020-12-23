import 'dart:convert';

import 'package:mesa_news/models/news_detalhe_model.dart';
import 'package:mesa_news/models/paginacao_model.dart';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

class NewsModel {
  // PaginacaoModel pagination;
  List<NewsDetalheModel> data;

  NewsModel({this.data});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
        // pagination: json["pagination"] = json["pagination"]
    );
  }

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
