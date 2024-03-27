import 'package:flutter/material.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/tabs/categories_tab.dart';
import 'package:news_app/tabs/tabs_list.dart';
import 'package:news_app/utils/assets_app.dart';
import 'package:news_app/utils/colors_app.dart';
import 'package:news_app/utils/theme_app.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "homescreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Category? category;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(AppAssets.background))),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.appBarBackground,
            title: const Text(
              "News App",
              style: AppTheme.appBarTextStyle,
            ),
            centerTitle: true,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(35))),
          ),
          backgroundColor: Colors.transparent,
          body: category == null
              ? Categories(onCategoryClick: onCategoryClick)
              : TabsList(categoryId: category!.backEndId)),
    );
  }

  void onCategoryClick(Category category) {
    setState(() {
      this.category = category;
    });
  }
}
