import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/category_controller.dart';
import '../widgets/body_loader.dart';

// Screen for details of each meal id

class SingleMealScreen extends StatelessWidget {
  SingleMealScreen({super.key});

  final controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    var mealId = Get.arguments["idMeal"];
    print(mealId);

    return GetBuilder<CategoryController>(initState: (_) async {
      await controller.getCategoryByid(mealId);
    }, builder: (context) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.share,
                size: 24,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.download,
                color: Colors.black,
                size: 24,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.favorite_border_outlined,
                color: Colors.black,
                size: 24,
              ),
              onPressed: () {},
            ),
          ],
          title: Text(
            controller.singleRes!.strMeal.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        body: controller.isDataLoading
            ? const BodyLoader()
            : Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 16.0,
                  top: 8,
                ),
                child: Column(
                  children: [
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(80),
                    //   child: Image(
                    //     image: NetworkImage(
                    //         controller.singleRes!.strMealThumb.toString()),
                    //     height: 400,
                    //     width: 600,
                    //     fit: BoxFit.contain,
                    //   ),
                    // ),
                    Container(
                        width: 400.00,
                        height: 400.00,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            image: NetworkImage(
                              controller.singleRes!.strMealThumb.toString(),
                            ),
                            fit: BoxFit.fitHeight,
                          ),
                        )),
                    const SizedBox(height: 10),

                    if (controller.singleRes != null)
                      Text(
                        controller.singleRes!.strArea.toString(),
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    const SizedBox(height: 10),
                    Text(
                      "Instructions:${controller.singleRes!.strInstructions.toString()}",
                      maxLines: 8,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     Container(
                    //       alignment: Alignment.center,
                    //       width: 200.00,
                    //       height: 50.00,
                    //       decoration: BoxDecoration(
                    //         color: Colors.orange,
                    //         borderRadius: BorderRadius.circular(25),
                    //       ),
                    //       child: const Text(
                    //         'Add to cart',
                    //         style: TextStyle(color: Colors.white, fontSize: 24),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
      );
    });
  }
}
