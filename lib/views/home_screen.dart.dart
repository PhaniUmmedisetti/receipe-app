import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meals/widgets/body_loader.dart';

import '../controllers/app_controller.dart';
import 'favourite_meal_screen.dart.dart';

// Home screen showing all categories

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      builder: (context) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.black,
                    size: 40,
                  ),
                  onPressed: () {
                    Get.to(FavouriteMealScreen());
                  },
                ),
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
            body: controller.isMainScreenLoading
                ? const BodyLoader()
                : Padding(
                    padding: const EdgeInsets.only(
                      top: 11.0,
                      left: 11.0,
                      right: 11.0,
                    ),

                    // implement GridView
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              (controller.isSelected)
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 16.0, left: 16, right: 16),
                                      child: Container(
                                        width: double.infinity,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius:
                                              BorderRadius.circular(88),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: TextField(
                                              controller: controller
                                                  .textEditingController,
                                              focusNode:
                                                  controller.textFocusNode,
                                              cursorColor: Colors.black,
                                              decoration: const InputDecoration(
                                                // prefix: Icon(Icons.search),
                                                hintText: "Search here...",
                                                border: InputBorder.none,
                                              ),
                                              onChanged: controller
                                                  .searchMealByCategory,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 16.0, bottom: 16),
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
                            ],
                          ),
                        ),
                        // Text('hellooooooooooooo'),
                        SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 160,
                          ),

                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  controller.listOfMeals.clear();
                                  controller.getCategoryByName(controller
                                      .listOfCategories[index].strCategory);
                                },
                                // Homescreen grid of meals
                                child: Column(children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                      controller.textEditingController.text
                                              .isNotEmpty
                                          ? controller
                                              .listOfSearchedCategories[index]
                                              .strCategoryThumb
                                          : controller.listOfCategories[index]
                                              .strCategoryThumb,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      controller.textEditingController.text
                                              .isNotEmpty
                                          ? controller
                                              .listOfSearchedCategories[index]
                                              .strCategory
                                          : controller.listOfCategories[index]
                                              .strCategory,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ]),
                              );
                            },
                            childCount:
                                controller.textEditingController.text.isNotEmpty
                                    ? controller.listOfSearchedCategories.length
                                    : controller.listOfCategories.length,
                          ),
                          // gridDelegate: gridDelegate,
                        ),
                        // GridView.builder(
                        //     gridDelegate:
                        //         const SliverGridDelegateWithMaxCrossAxisExtent(
                        //       maxCrossAxisExtent: 160,
                        //       // childAspectRatio: 3 / 2,
                        //       crossAxisSpacing: 10,
                        //       mainAxisSpacing: 20,
                        //     ),
                        //     itemCount: controller
                        //             .textEditingController.text.isNotEmpty
                        //         ? controller.listOfSearchedCategories.length
                        //         : controller.listOfCategories.length,
                        //     itemBuilder: (BuildContext ctx, index) {
                        //       return GestureDetector(
                        //         onTap: () {
                        //           controller.listOfMeals.clear();
                        //           controller.getCategoryByName(controller
                        //               .listOfCategories[index].strCategory);
                        //         },
                        //         // Homescreen grid of meals
                        //         child: Column(children: [
                        //           CircleAvatar(
                        //             backgroundColor: Colors.transparent,
                        //             radius: 50,
                        //             backgroundImage: NetworkImage(
                        //               controller.listOfCategories[index]
                        //                   .strCategoryThumb,
                        //             ),
                        //           ),
                        //           Expanded(
                        //             child: Text(
                        //               controller.listOfCategories[index]
                        //                   .strCategory,
                        //               style: const TextStyle(
                        //                 fontSize: 18,
                        //                 fontWeight: FontWeight.bold,
                        //               ),
                        //             ),
                        //           )
                        //         ]),
                        //       );
                        //     }),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
