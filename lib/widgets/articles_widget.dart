import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/widgets/article_view.dart';

class ArticlesWidget extends StatelessWidget {
  const ArticlesWidget({Key? key, required this.article}) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(article: article),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: article.urlToImage ?? '',
              height: MediaQuery.of(context).size.height * 0.25,
              placeholder: (_, __) => const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
              errorWidget: (_, __, ___) => const Icon(
                Icons.image_not_supported_outlined,
                color: Colors.red,
              ),
            ),
          ),
          Text(
            article.source?.name ?? '',
            textAlign: TextAlign.start,
            style: const TextStyle(color: Color(0xff79828B)),
          ),
          Text(article.title ?? '', textAlign: TextAlign.start),
          Text(
            article.publishedAt ?? '',
            textAlign: TextAlign.end,
            style: TextStyle(color: Color(0xff79828B)),
          ),
        ],
      ),
    );
  }
}
