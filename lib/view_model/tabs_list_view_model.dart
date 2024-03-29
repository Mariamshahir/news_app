import 'package:flutter/material.dart';
import 'package:news_app/data/api_manger.dart';
import 'package:news_app/model/source.dart';
import 'package:news_app/model/sourceresponse.dart';

class TabsListViewModel extends ChangeNotifier {
  TapsListState state = TapsListState.loading;
  List<Source> sources = [];
  String errorMessage = "";

  Future<void> loadTabsList(String categoryId) async {
    state = TapsListState.loading;
    notifyListeners();
    try {
      SourcesResponse sourcesResponse =
          await ApiManger.loadTabsList(categoryId);
      state = TapsListState.success;
      sources = sourcesResponse.sources!;
      notifyListeners();
    } catch (exception) {
      state = TapsListState.error;
      errorMessage = exception.toString();
      notifyListeners();
    }
  }
}

enum TapsListState { success, loading, error }
