import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meals/widgets/body_loader.dart';

import '../controllers/category_controller.dart';

// Home screen showing all categories

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final categoryController = Get.put(CategoryController()); 
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (context) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black,
                    child: IconButton(
                      // alignment: Alignment.bottomCenter,
                      icon: const Icon(
                        Icons.person,
                        color: Colors.white,
                        // size: 35,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Hello, Phani',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // centerTitle: true,
            ),
            body: categoryController.isMainScreenLoading
                ? const BodyLoader()
                : Padding(
                    padding: const EdgeInsets.only(
                      top: 11.0,
                      left: 11.0,
                      right: 11.0,
                    ),

                    // implement GridView.builder
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 16.0, bottom: 16),
                              child: Text(
                                'List of categories :-',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 160,
                                // childAspectRatio: 3 / 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 20,
                              ),
                              itemCount:
                                  categoryController.listOfCategories.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return GestureDetector(
                                  onTap: () {
                                    categoryController.listOfMeals.clear();
                                    categoryController.getCategoryByName(
                                        categoryController
                                            .listOfCategories[index]
                                            .strCategory);
                                  },
                                  // Homescreen grid of meals
                                  child: Column(children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                        categoryController
                                            .listOfCategories[index]
                                            .strCategoryThumb,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        categoryController
                                            .listOfCategories[index]
                                            .strCategory,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ]),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
