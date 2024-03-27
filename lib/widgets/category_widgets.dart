import 'package:flutter/material.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/utils/colors_app.dart';

class CategoryView extends StatelessWidget {
  final Category category;

  const CategoryView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: category.backgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(25),
              topRight: const Radius.circular(25),
              bottomLeft: category.isLeftSided
                  ? Radius.zero
                  : const Radius.circular(25),
              bottomRight: !category.isLeftSided
                  ? Radius.zero
                  : const Radius.circular(25))),
      child: Column(
        children: [
          Image.asset(
            category.imagePath,
            height: MediaQuery.of(context).size.height * 0.14,
          ),
          Text(
            category.title,
            style: const TextStyle(
                fontSize: 22,
                color: AppColors.white,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
