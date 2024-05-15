import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/view_model/taps_widgets_view_model.dart';
import 'package:news_app/widgets/app_error.dart';
import 'package:news_app/widgets/articles_widget.dart';
import 'package:news_app/widgets/loddingapp.dart';
import 'package:provider/provider.dart';

class TapsDetails extends StatefulWidget {
  final String sourceId;

  const TapsDetails({super.key, required this.sourceId});

  @override
  State<TapsDetails> createState() => _TapsDetailsState();
}

class _TapsDetailsState extends State<TapsDetails> {
  TapsWidgetsViewModel viewModel = TapsWidgetsViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.loadArticlesList(widget.sourceId);
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
            return AppError(
              error: viewModel.errorMessage,
              onRefreshClick: () {
                viewModel.loadArticlesList(widget.sourceId);
              },
            );
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
            return ArticlesWidget(article: articles[index]!);
          }),
    );
  }
}
