import 'package:flutter/material.dart';
import 'package:news_app/tabs/news/tabs_list.dart';
import 'package:news_app/utils/colors_app.dart';
import 'package:news_app/utils/theme_app.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "homescreen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appBarBackground,
          title: const Text(
            "News App",
            style: AppTheme.appBarTextStyle,
          ),
          centerTitle: true,
        ),
        body: const TabsList());
  }
}
