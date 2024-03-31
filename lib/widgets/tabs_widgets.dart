import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/view_model/taps_widgets_view_model.dart';
import 'package:news_app/widgets/app_error.dart';
import 'package:news_app/widgets/article_view.dart';
import 'package:news_app/widgets/loddingapp.dart';
import 'package:provider/provider.dart';

class TapsDetails extends StatefulWidget {
  final String sourceId;
  final String? searchKeyword;

  const TapsDetails({super.key, required this.sourceId, this.searchKeyword});

  @override
  State<TapsDetails> createState() => _TapsDetailsState();
}

class _TapsDetailsState extends State<TapsDetails> {
  TapsWidgetsViewModel viewModel = TapsWidgetsViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.loadArticlesList(widget.sourceId,widget.searchKeyword);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Builder(
        builder: (context) {
          viewModel = Provider.of<TapsWidgetsViewModel>(context, listen: true);
          if (viewModel.state == TapsWidgetsState.loading) {
            return const LoaddingApp();
          } else if (viewModel.state == TapsWidgetsState.success) {
            return articlesList(viewModel.articles);
          } else {
            return AppError(error: viewModel.errorMessage,onRefreshClick: (){
              viewModel.loadArticlesList(widget.sourceId,widget.searchKeyword);
            },);
          }
        },
      ),
    );
  }

  Widget articlesList(List<Article?> articles) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.71, vertical: 15),
      child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return articlesWidget(context, articles[index]!);
          }),
    );
  }

  Widget articlesWidget(BuildContext context, Article article) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleView(article: article)));
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
              )),
              errorWidget: (_, __, ___) => const Icon(
                Icons.image_not_supported_outlined,
                color: Colors.red,
              ),
            ),
          ),
          Text(
            article.source?.name ?? '',
            textAlign: TextAlign.start,
            style: TextStyle(color: Color(0xff79828B)),
          ),
          Text(article.title ?? '', textAlign: TextAlign.start),
          Text(article.publishedAt ?? '',
              textAlign: TextAlign.end,
              style: TextStyle(color: Color(0xff79828B)))
        ],
      ),
    );
  }
}
