import 'package:flutter/material.dart';
import 'package:news_app/data/api_manger.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/utils/colors_app.dart';
import 'package:news_app/widgets/articles_widget.dart';
import 'package:news_app/widgets/loddingapp.dart';

class SearchArticle extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(onPressed: (){
        showResults(context);
      }, icon: const Icon(Icons.search))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
   return IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.close));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: ApiManger.loadSearchArticles(query),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorApp(
              error: "Error fetching article");
        } else if (snapshot.hasData) {
          List<Article>? articles = snapshot.data!.articles;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.71, vertical: 15),
            child: ListView.builder(
                itemCount: articles?.length,
                itemBuilder: (context, index) {
                  return ArticlesWidget(article: articles![index]);
                }),
          );
        } else {
          return const LoaddingApp();
        }
      },
    );
  }


  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: AppColors.white),
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.vertical(bottom: Radius.circular(35))),
        color: AppColors.appBarBackground,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
    );

  }

  Widget ErrorApp({required String error}) {
    return Center(child: Text(error,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),));
  }
}