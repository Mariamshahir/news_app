import 'package:flutter/material.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/utils/colors_app.dart';
import 'package:news_app/widgets/category_widgets.dart';

class Categories extends StatelessWidget {
  final void Function(Category) onCategoryClick;

  const Categories({super.key, required this.onCategoryClick});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 36, horizontal: 19),
          child: const Text(
            "Pick your category of interest",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.gray),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: GridView.builder(
                itemCount: Category.categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 25),
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        onCategoryClick(Category.categories[index]);
                      },
                      child: CategoryView(
                        category: Category.categories[index],
                      ));
                }),
          ),
        )
      ],
    );
  }
}
