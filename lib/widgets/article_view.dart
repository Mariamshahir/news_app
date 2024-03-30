import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/provider/language_provider.dart';
import 'package:news_app/utils/app_language.dart';
import 'package:news_app/utils/assets_app.dart';
import 'package:news_app/utils/colors_app.dart';
import 'package:news_app/utils/theme_app.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleView extends StatefulWidget {
  static const String routeName = "articleview";
  final Article article;

  const ArticleView({super.key, required this.article});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  late LanguageProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.appBarBackground,
        title: Text(
          context.getLocalizations.newsTitle,
          style: AppTheme.appBarTextStyle,
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(35))),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 29.5),
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(AppAssets.background))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: widget.article.urlToImage ?? '',
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
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.article.source?.name ?? '',
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Color(0xff79828B)),
                  ),
                  Text(
                    widget.article.title ?? '',
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff42505C)),
                  ),
                  Text(
                    widget.article.publishedAt ?? '',
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Color(0xff79828B)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 11),
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                        color: const Color(0x80757575),
                        borderRadius: BorderRadius.circular(25)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(widget.article.description ?? '',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            )),
                        const Spacer(),
                        InkWell(
                          onTap: () async {
                            final url = widget.article.url ?? '';
                            if (url != null && await canLaunch(url)) {
                              await launch(url);
                            } else {}
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                context.getLocalizations.viewFullArticle,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(Icons.arrow_right_sharp)
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

void openUrl(String url) async {
  try {
    await Process.run('cmd', ['/c', 'start', url]);
  } catch (e) {
    print('Error: $e');
  }
}
