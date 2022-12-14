import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meals/views/meal_screen.dart';

import '../controllers/category_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final categoryController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(11.0),
            // implement GridView.builder
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: categoryController.listOfCategories.length,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      categoryController.listOfMeals.clear();
                      categoryController.getCategoryByName(categoryController
                          .listOfCategories[index].strCategory);
                    },
                    child: Column(children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          categoryController
                              .listOfCategories[index].strCategoryThumb,
                        ),
                      ),
                      Text(
                        categoryController.listOfCategories[index].strCategory,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ]),
                  );
                }),
          ),
        );
      },
    );
  }
}
