import 'package:flutter/material.dart';
import 'package:news_app/utils/assets_app.dart';
import 'package:news_app/utils/colors_app.dart';

class Category {
  String backEndId;
  String title;
  String imagePath;
  bool isLeftSided;
  Color backgroundColor;

  Category(
      {required this.backEndId,
      required this.title,
      required this.imagePath,
      required this.isLeftSided,
      required this.backgroundColor});

  static List<Category> categories = [
    Category(
        backEndId: "sports",
        title: "Sports",
        imagePath: AppAssets.sports,
        isLeftSided: true,
        backgroundColor: AppColors.sports),
    Category(
        backEndId: "technology",
        title: "Politics",
        imagePath: AppAssets.politics,
        isLeftSided: false,
        backgroundColor: AppColors.politics),
    Category(
        backEndId: "health",
        title: "Health",
        imagePath: AppAssets.health,
        isLeftSided: true,
        backgroundColor: AppColors.health),
    Category(
        backEndId: "business",
        title: "Bussines",
        imagePath: AppAssets.bussines,
        isLeftSided: false,
        backgroundColor: AppColors.bussines),
    Category(
        backEndId: "entertainment",
        title: "Environment",
        imagePath: AppAssets.environment,
        isLeftSided: true,
        backgroundColor: AppColors.environment),
    Category(
        backEndId: "science",
        title: "Science",
        imagePath: AppAssets.science,
        isLeftSided: false,
        backgroundColor: AppColors.science),
  ];
}
