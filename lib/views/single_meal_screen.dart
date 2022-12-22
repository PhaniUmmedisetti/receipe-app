import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/category_controller.dart';
import '../widgets/body_loader.dart';

// Screen for details of each meal id

class SingleMealScreen extends StatelessWidget {
  SingleMealScreen({super.key});

  final controller = Get.put(CategoryController());
  // late String ingredients;
  // late String measurment;

  Widget ingredientsMeasure(String? ingredients, String? measurment) {
    print(" ing : $ingredients mea : $measurment");
    return (ingredients == null ||
            ingredients == "" ||
            measurment == null ||
            measurment == "")
        ? Container()
        : Row(
            children: [
              Text(
                ingredients,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 5),
              Text(
                measurment,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          );
  }

//  late String ingredients;
//   late String measurment;
//   Widget ingredientsMeasure(){
//     return Row(
//       children: [
//         //add font size 15
//         Text(ingredients),
//         Text(measurment),
//       ],
//     );
  @override
  Widget build(BuildContext context) {
    var mealId = Get.arguments["idMeal"];
    print(mealId);

    return GetBuilder<CategoryController>(initState: (_) async {
      await controller.getCategoryByid(mealId);
      await controller.getIsMealFavorite(mealId);
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
            if (!controller.isDataLoading)
              IconButton(
                icon: Icon(
                  controller.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: controller.isFavorite ? Colors.red : Colors.black,
                  size: 24,
                ),
                onPressed: () {
                  controller.setIsMealFavorite(mealId, !controller.isFavorite);
                },
              ),
          ],
          title: Text(
            controller.singleRes?.strMeal.toString() ?? "",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        body: controller.isDataLoading
            ? const BodyLoader()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: 16.0,
                    top: 8,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                          controller.singleRes!.strMeal.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      // const SizedBox(height: 14),
                      // Row(
                      //   children: [
                      //     const Align(
                      //       alignment: Alignment.centerLeft,
                      //       child: Text(
                      //         'Name :-',
                      //         style: TextStyle(
                      //             fontSize: 16,
                      //             fontWeight: FontWeight.bold,
                      //             overflow: TextOverflow.ellipsis),
                      //       ),
                      //     ),
                      //     const SizedBox(width: 5),
                      //     Align(
                      //       alignment: Alignment.centerLeft,
                      //       child: Expanded(
                      //         child: Text(
                      //           controller.singleRes!.strMeal.toString(),
                      //           maxLines: 8,
                      //           textAlign: TextAlign.left,
                      //           style: const TextStyle(
                      //             fontSize: 12,
                      //             fontWeight: FontWeight.bold,
                      //             color: Colors.black,
                      //             overflow: TextOverflow.visible,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      // // Ink(),

                      const SizedBox(height: 8),
                      //
                      //
                      // line 1
                      //
                      //
                      Row(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Category :-',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              controller.singleRes!.strCategory.toString(),
                              maxLines: 8,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),
                      //
                      //
                      // line 2
                      //
                      //
                      Row(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Area of origin :-',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              controller.singleRes!.strArea.toString(),
                              maxLines: 8,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      //
                      //
                      // line 3
                      //
                      //

                      const SizedBox(height: 8),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Ingredients :-',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 5),

                      ingredientsMeasure(controller.singleRes!.strIngredient1,
                          controller.singleRes!.strMeasure1),
                      ingredientsMeasure(controller.singleRes!.strIngredient2,
                          controller.singleRes!.strMeasure2),
                      ingredientsMeasure(controller.singleRes!.strIngredient3,
                          controller.singleRes!.strMeasure3),
                      ingredientsMeasure(controller.singleRes!.strIngredient4,
                          controller.singleRes!.strMeasure4),
                      ingredientsMeasure(controller.singleRes!.strIngredient5,
                          controller.singleRes!.strMeasure5),
                      ingredientsMeasure(controller.singleRes!.strIngredient6,
                          controller.singleRes!.strMeasure6),
                      ingredientsMeasure(controller.singleRes!.strIngredient7,
                          controller.singleRes!.strMeasure7),
                      ingredientsMeasure(controller.singleRes!.strIngredient8,
                          controller.singleRes!.strMeasure8),
                      ingredientsMeasure(controller.singleRes!.strIngredient9,
                          controller.singleRes!.strMeasure9),
                      ingredientsMeasure(controller.singleRes!.strIngredient10,
                          controller.singleRes!.strMeasure10),
                      ingredientsMeasure(controller.singleRes!.strIngredient11,
                          controller.singleRes!.strMeasure11),
                      ingredientsMeasure(controller.singleRes!.strIngredient12,
                          controller.singleRes!.strMeasure12),
                      ingredientsMeasure(controller.singleRes!.strIngredient13,
                          controller.singleRes!.strMeasure13),
                      ingredientsMeasure(controller.singleRes!.strIngredient14,
                          controller.singleRes!.strMeasure14),
                      ingredientsMeasure(controller.singleRes!.strIngredient15,
                          controller.singleRes!.strMeasure15),
                      ingredientsMeasure(controller.singleRes!.strIngredient16,
                          controller.singleRes!.strMeasure16),
                      ingredientsMeasure(controller.singleRes!.strIngredient17,
                          controller.singleRes!.strMeasure17),
                      ingredientsMeasure(controller.singleRes!.strIngredient18,
                          controller.singleRes!.strMeasure18),
                      ingredientsMeasure(controller.singleRes!.strIngredient19,
                          controller.singleRes!.strMeasure19),
                      ingredientsMeasure(controller.singleRes!.strIngredient20,
                          controller.singleRes!.strMeasure20),

                      //
                      //
                      // line 4
                      //
                      //
                      const SizedBox(height: 8),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Instructions :-',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 5),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          controller.singleRes!.strInstructions.toString(),
                          // maxLines: 8,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
      );
    });
  }
}

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
