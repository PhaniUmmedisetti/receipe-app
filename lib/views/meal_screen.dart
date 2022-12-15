import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/category_controller.dart';
import '../widgets/main_item_card.dart';

class MealScreen extends StatelessWidget {
  MealScreen({super.key});
  final categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Meal Screen'),
            // actions: <Widget>[
            //   IconButton(
            //     icon: const Icon(
            //       Icons.favorite_border_outlined,
            //       color: Colors.white,
            //     ),
            //     onPressed: () {},
            //   ),
            // ],
          ),
          body:
              // controller.isDataLoading
              // Container(),
              //     :
              SingleChildScrollView(
            child: Column(
              children: [
                ...categoryController.listOfMeals.map((e) => MainScreenItemCard(
                      arrowIcon: Icons.arrow_right,
                      image: e.strMealThumb,
                      title: e.strMeal,
                      onTap: () {
                        categoryController.goToSingleScreen(e.idMeal);
                      },
                      favIcon: Icons.favorite_border_outlined,
                      // favIcon: Icons.favorite,
                    )),
              ],
            ),
          ));
    });
  }
}
