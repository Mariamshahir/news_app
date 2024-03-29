import 'package:flutter/material.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/tabs/categories_tab.dart';
import 'package:news_app/tabs/settings.dart';
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
  late Widget body;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    body = Categories(onCategoryClick: onCategoryClick);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: ()async {
          if(body is Categories){
            print("true");
            return true;
          }else{
            setState(() {
              body==Categories(onCategoryClick: onCategoryClick);
            });
            print("false");
            return false;
          }
        },
        child: Container(
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
              child: const Center(
                child: Text(
                  "News App!",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white),
                ),
              )),
          const SizedBox(
            height: 25,
          ),
          buildDrawerItem(Icons.list_sharp, "Categories", () {
            setState(() {
              body = Categories(onCategoryClick: onCategoryClick);
              Navigator.pop(context);
            });
          }),
          buildDrawerItem(Icons.settings, "Settings", () {
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
      body=TabsList(categoryId: category.backEndId);
    });
  }
}
