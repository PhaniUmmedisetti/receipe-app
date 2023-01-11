import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/app_controller.dart';
import 'favourite_meal_screen.dart.dart';
import 'profile_screen.dart';

// Screen that shows the first page i.e shows all categories

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      builder: (controller) {
        return Scaffold(
          // backgroundColor: Theme.of(context).backgroundColor,
          appBar: controller.isMainScreenLoading
              ? null
              : AppBar(
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.favorite_border_outlined,
                        color: Theme.of(context).primaryColorLight,
                        size: 40,
                      ),
                      onPressed: () {
                        Get.to(FavouriteMealScreen());
                      },
                    ),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Theme.of(context).primaryColorLight,
                        child: IconButton(
                          // alignment: Alignment.bottomCenter,
                          icon: Icon(
                            Icons.person,
                            color: Theme.of(context).primaryColor,
                            // size: 35,
                          ),
                          onPressed: () {
                            Get.to(const ProfileScreen());
                          },
                        ),
                      ),
                    ),
                  ],
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Hello, Phani',
                      style: TextStyle(
                        // color: Colors.black,
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // centerTitle: true,
                ),
          body: controller.isMainScreenLoading
              ? const Padding(
                  padding: EdgeInsets.only(
                    top: 11.0,
                    left: 11.0,
                    right: 11.0,
                  ),
                  child: HomeShimmer(),
                )
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
                                        borderRadius: BorderRadius.circular(88),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: TextField(
                                            controller: controller
                                                .textEditingController,
                                            focusNode: controller.textFocusNode,
                                            cursorColor: Colors.black,
                                            decoration: const InputDecoration(
                                              // prefix: Icon(Icons.search),
                                              hintText: "Search here...",
                                              border: InputBorder.none,
                                            ),
                                            onChanged:
                                                controller.searchMealByCategory,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            // if (controller.textEditingController.text.isEmpty !=
                            //     controller.listOfSearchedCategories.isEmpty)
                            //   // const Text('No meal found')
                            //   const Padding(
                            //     padding: EdgeInsets.all(8.0),
                            //     child: Text(
                            //       'No meal found',
                            //       style: TextStyle(fontSize: 20),
                            //     ),
                            //   )
                            (controller.textEditingController.text.isNotEmpty &&
                                    controller.listOfSearchedCategories.isEmpty)
                                ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'No category found',
                              style: TextStyle(fontSize: 20),
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
                      // if (controller.textEditingController.text.isEmpty !=
                      //     controller.listOfSearchedCategories.isEmpty)
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
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 191, 188, 188),
            highlightColor: Colors.grey.shade300,
            child: const CircleAvatar(
              radius: 20,
            ),
          ),
          const SizedBox(width: 6),
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 191, 188, 188),
            highlightColor: Colors.grey.shade300,
            child: const CircleAvatar(
              radius: 20,
            ),
          ),
          const SizedBox(width: 6),
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 191, 188, 188),
            highlightColor: Colors.grey.shade300,
            child: const CircleAvatar(
              radius: 20,
            ),
          ),
          const SizedBox(width: 6),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 191, 188, 188),
          highlightColor: Colors.grey.shade300,
          child: const Card(
            child: SizedBox(
              height: 34,
              width: 150,
            ),
          ),
        ),
        // bottom: ,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 191, 188, 188),
              highlightColor: Colors.grey.shade300,
              child: const Card(
                child: SizedBox(
                  height: 34,
                  width: 150,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 32.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 26),
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Shimmer.fromColors(
                        baseColor: const Color.fromARGB(255, 191, 188, 188),
                        highlightColor: Colors.grey.shade300,
                        child: const CircleAvatar(
                          radius: 50,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
