import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/api_manger.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/widgets/app_error.dart';
import 'package:news_app/widgets/loddingapp.dart';

class TapsDetails extends StatefulWidget {
  final String sourceId;

  const TapsDetails({super.key, required this.sourceId});

  @override
  State<TapsDetails> createState() => _TapsDetailsState();
}

class _TapsDetailsState extends State<TapsDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManger.loadArticlesList(widget.sourceId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return AppError(error: snapshot.error.toString());
          } else if (snapshot.hasData) {
            return articlesList(snapshot.data!.articles!);
          } else {
            return LoaddingApp();
          }
        });
  }

  Widget articlesList(List<Article?> articles) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.71,vertical: 15),
      child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return articlesWidget(context,articles[index]!);
          }),
    );
  }

  Widget articlesWidget(BuildContext context,Article article) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImage(
            imageUrl: article.urlToImage!,
            height: MediaQuery.of(context).size.height*0.25,
            placeholder: (_, __) => const Center(
                child: CircularProgressIndicator(
              color: Colors.blue,
            )),
            errorWidget: (_, __, ___) => const Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
          ),
        ),
        Text(article.source?.name ?? '',textAlign: TextAlign.start,style: TextStyle(color: Color(0xff79828B)),),
        Text(article.title ?? '',textAlign: TextAlign.start),
        Text(article.publishedAt ?? '',textAlign: TextAlign.end,style: TextStyle(color: Color(0xff79828B)))
      ],
    );
  }
}
