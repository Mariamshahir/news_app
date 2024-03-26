import 'package:news_app/model/article.dart';

class ArticlesResponse {
  String? status;
  num? totalResults;
  List<Article>? articles;
  String? code;
  String? message;

  ArticlesResponse(
      {this.articles, this.status, this.totalResults, this.message, this.code});

  ArticlesResponse.fromJson(dynamic json) {
    status = json['status'];
    totalResults = json['totalResults'];
    message = json['message'];
    code = json['code'];
    if (json['articles'] != null) {
      articles = [];
      json['articles'].forEach((v) {
        articles?.add(Article.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['totalResults'] = totalResults;
    if (articles != null) {
      map['articles'] = articles?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
