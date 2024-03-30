import 'package:flutter/material.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/provider/language_provider.dart';
import 'package:news_app/tabs/categories_tab.dart';
import 'package:news_app/tabs/settings.dart';
import 'package:news_app/tabs/tabs_list.dart';
import 'package:news_app/utils/app_language.dart';
import 'package:news_app/utils/assets_app.dart';
import 'package:news_app/utils/colors_app.dart';
import 'package:news_app/utils/theme_app.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "homescreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Widget body;
  late LanguageProvider provider;

  @override
  void initState() {
    super.initState();
    body = Categories(onCategoryClick: onCategoryClick);
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (body is Categories) {
            return true;
          } else {
            setState(() {
              body == Categories(onCategoryClick: onCategoryClick);
            });
            return false;
          }
        },
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(AppAssets.background))),
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.appBarBackground,
                title: Text(
                  context.getLocalizations.newsApp,
                  style: AppTheme.appBarTextStyle,
                ),
                centerTitle: true,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(35))),
                leading: Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: AppColors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
              ),
              drawer: buildDrawer(),
              backgroundColor: Colors.transparent,
              body: body),
        ),
      ),
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          Container(
              color: AppColors.appBarBackground,
              width: double.infinity,
              padding: const EdgeInsets.all(50),
              child: Center(
                child: Text(
                  context.getLocalizations.newApp,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white),
                ),
              )),
          const SizedBox(
            height: 25,
          ),
          buildDrawerItem(Icons.list_sharp, context.getLocalizations.categories,
              () {
            setState(() {
              body = Categories(onCategoryClick: onCategoryClick);
              Navigator.pop(context);
            });
          }),
          buildDrawerItem(Icons.settings, context.getLocalizations.settings,
              () {
            setState(() {
              body = const Settings();
              Navigator.pop(context);
            });
          })
        ],
      ),
    );
  }

  Widget buildDrawerItem(IconData iconData, String title, Function onClick) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 35,
            ),
            const SizedBox(
              width: 13,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  void onCategoryClick(Category category) {
    setState(() {
      body = TabsList(categoryId: category.backEndId);
    });
  }
}
