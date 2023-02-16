import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meals/constants.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/app_controller.dart';
import '../widgets/main_screen_card.dart';

// Screen that shows meals list of single category
class MealScreen extends StatelessWidget {
  MealScreen({super.key});
  final controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              // color: Colors.black,
              color: Theme.of(context).primaryColorLight,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Meal Screen',
              style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: controller.isSelected
                    ? Icon(
                        Icons.close,
                        color: Theme.of(context).primaryColorLight,
                        size: 40,
                      )
                    : Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColorLight,
                        size: 40,
                      ),
                onPressed: () {
                  controller.toggle();
                },
              ),
            ],
          ),
          body: controller.isDataLoading
              ? const MealTileShimmer()
              : Padding(
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
                                    controller:
                                        controller.textEditingController,
                                    focusNode: controller.textFocusNode,
                                    cursorColor: Colors.black,
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                      // prefix: Icon(Icons.search),

                                      hintText: "Search here...",
                                      border: InputBorder.none,
                                    ),
                                    onChanged:
                                        controller.searchSingleMealByName,
                                  ),
                                ),
                              ),
                            ),
                          ),
                       
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
                            ),
                          ),

                        if (controller.textEditingController.text.isNotEmpty &&
                            controller.listOfSearchedSingleMeals.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'No meal found',
                              style: TextStyle(fontSize: 20),
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
                            ),
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
//MealTileShimmer 

class MealTileShimmer extends StatelessWidget {
  const MealTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            SizedBox(
              height: 110,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 0.15,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(18),
                      leading: Shimmer.fromColors(
                        baseColor: const Color.fromARGB(255, 191, 188, 188),
                        highlightColor: Colors.grey.shade300,
                        child: const CircleAvatar(
                          radius: 30,
                        ),
                      ),
                      title: Shimmer.fromColors(
                        baseColor: const Color.fromARGB(255, 191, 188, 188),
                        highlightColor: Colors.grey.shade300,
                        child: Container(
                          height: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
