import 'package:flutter/material.dart';
import 'package:news_app/data/api_manger.dart';
import 'package:news_app/model/articlesresponse.dart';
import 'package:news_app/utils/colors_app.dart';
import 'package:news_app/widgets/tabs_widgets.dart';

class SearchTab extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: AppColors.appBarBackground,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
    );
  }

  late Future<ArticlesResponse> getArticlesDataModel;

  SearchTab() {
    getArticlesDataModel = ApiManger.loadArticlesList(sourceId: '', query: query);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          showResults(context);
        },
        icon: const Icon(Icons.search),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.clear,
        size: 32,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: ApiManger.loadArticlesList(sourceId: "", query: query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }
        var articles = snapshot.data?.articles ?? [];
        return Expanded(
          child: Container(
            child: ListView.builder(
              itemBuilder: (context, index) {
                var article = articles[index];
                return TapsDetails(sourceId: article.source!.id!, query: '',);
              },
              itemCount: articles.length,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text(
        'Search',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
