import 'dart:convert';

PaginacaoModel paginacaoFromJson(String str) =>
    PaginacaoModel.fromJson(json.decode(str));

class PaginacaoModel {
  int current_page;
  int per_page;
  int total_pages;
  int total_items;

  PaginacaoModel({this.current_page, this.per_page, this.total_pages, this.total_items});

  factory PaginacaoModel.fromJson(Map<String, dynamic> json) {
    return PaginacaoModel(
      current_page: json["current_page"],
      per_page: json["per_page"],
      total_pages: json["total_pages"],
      total_items: json["total_items"],
    );
  }

  Map<String, dynamic> toJson() => {
    "current_page": current_page,
    "per_page": per_page,
    "total_pages": total_pages,
    "total_items": total_items,
  };
}
