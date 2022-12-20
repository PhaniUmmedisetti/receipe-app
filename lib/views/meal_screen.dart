import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/category_controller.dart';
import '../widgets/main_item_card.dart';

// Single meal category screen
class MealScreen extends StatelessWidget {
  MealScreen({super.key});
  final categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (controller) {
      return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'Meal Screen',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            body:
                // controller.isDataLoading
                // Container(),
                //     :
                Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...categoryController.listOfMeals.map(
                      (e) => MainScreenItemCard(
                        arrowIcon: Icons.arrow_right,
                        image: e.strMealThumb,
                        title: e.strMeal,
                        onTap: () {
                          categoryController.goToSingleScreen(e.idMeal);
                        },
                        favIcon: Icons.favorite_border_outlined,
                        // favIcon: Icons.favorite,
                      ),
                    ),
                  ],
                ),
              ),
            )),
      );
    });
  }
}
