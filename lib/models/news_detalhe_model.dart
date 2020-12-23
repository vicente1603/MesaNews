import 'dart:convert';

NewsDetalheModel newsDetalheModelFromJson(String str) =>
    NewsDetalheModel.fromJson(json.decode(str));

String newsDetalheModelToJson(NewsDetalheModel data) =>
    json.encode(data.toJson());

class NewsDetalheModel {
  String title;
  String description;
  String content;
  String author;
  String published_at;
  bool highlight;
  String url;
  String image_url;

  NewsDetalheModel({
    this.title,
    this.description,
    this.content,
    this.author,
    this.published_at,
    this.highlight,
    this.url,
    this.image_url,
  });

  factory NewsDetalheModel.fromJson(Map<String, dynamic> json) {
    return NewsDetalheModel(
        title: json["title"],
        description: json["description"],
        content: json["content"],
        author: json["author"],
        published_at: json["published_at"],
        highlight: json["highlight"],
        url: json["url"],
        image_url: json["image_url"]);
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "content": content,
        "author": author,
        "published_at": published_at,
        "highlight": highlight,
        "url": url,
        "image_url": image_url
      };
}
