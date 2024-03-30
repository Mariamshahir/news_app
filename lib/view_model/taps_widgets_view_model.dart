import 'package:flutter/material.dart';
import 'package:news_app/data/api_manger.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/model/articlesresponse.dart';

class TapsWidgetsViewModel extends ChangeNotifier{
  TapsWidgetsState state = TapsWidgetsState.loading;
  List<Article> articles = [];
  String errorMessage = "";
  Future<void> loadArticlesList(String sourceId,String? searchKeyword) async {
    state = TapsWidgetsState.loading;
    notifyListeners();
    try {
      ArticlesResponse articlesResponse =
      await ApiManger.loadArticlesList(sourceId,searchKeyword);
      state = TapsWidgetsState.success;
      articles = articlesResponse.articles!;
      notifyListeners();
    } catch (exception) {
      state = TapsWidgetsState.error;
      errorMessage = exception.toString();
      notifyListeners();
    }
  }
}
enum TapsWidgetsState { success, loading, error }
