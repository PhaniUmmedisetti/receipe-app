import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meals/constants.dart';
import '../controllers/app_controller.dart';
import '../widgets/main_item_card.dart';

// Single meal category screen
class MealScreen extends StatelessWidget {
  MealScreen({super.key});
  final controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(builder: (controller) {
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
                  icon: controller.isSelected
                      ? const Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 40,
                        )
                      : const Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 40,
                        ),
                  onPressed: () {
                    controller.toggle();
                  },
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
                    if (controller.isSelected)
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(88),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: TextField(
                                controller: controller.textEditingController,
                                focusNode: controller.textFocusNode,
                                cursorColor: Colors.black,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  // prefix: Icon(Icons.search),

                                  hintText: "Search here...",
                                  border: InputBorder.none,
                                ),
                                onChanged: controller.searchSingleMealByName,
                              ),
                            ),
                          ),
                        ),
                      ),
                    // controller.textEditingController.text.isNotEmpty
                    //               ? controller.listOfSearchedCategories.length
                    //               : controller.listOfCategories.length

                    if (controller.textEditingController.text.isNotEmpty)
                      ...controller.listOfSearchedSingleMeals.mapIndexed(
                        (e, index) => MainScreenItemCard(
                          arrowIcon: Icons.arrow_right,
                          image: e.strMealThumb,
                          title: e.strMeal,
                          onTap: () {
                            controller.goToSingleScreen(e.idMeal);
                          },
                          favIcon: Icons.favorite_border_outlined,
                          // favIcon: Icons.favorite,
                        ),
                      ),
                    if (controller.textEditingController.text.isEmpty)
                      ...controller.listOfMeals.mapIndexed(
                        (e, index) => MainScreenItemCard(
                          arrowIcon: Icons.arrow_right,
                          image: e.strMealThumb,
                          title: e.strMeal,
                          onTap: () {
                            controller.goToSingleScreen(e.idMeal);
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
