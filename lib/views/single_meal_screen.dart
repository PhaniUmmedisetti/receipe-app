import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/app_controller.dart';
import '../widgets/body_loader.dart';

// Screen for details of each meal id

class SingleMealScreen extends StatelessWidget {
  SingleMealScreen({super.key});

  final controller = Get.put(AppController());
  // late String ingredients;
  // late String measurment;

  Widget ingredientsMeasure(String? ingredients, String? measurment) {
    // print(" ing : $ingredients mea : $measurment");
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

  @override
  Widget build(BuildContext context) {
    var mealId = Get.arguments["idMeal"];
    print(mealId);

    return GetBuilder<AppController>(initState: (_) async {
      await controller.getCategoryByid(mealId);
      await controller.getIsMealFavorite(mealId);
    }, builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColorLight,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.share,
                size: 24,
                color: Theme.of(context).primaryColorLight,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.download,
                color: Theme.of(context).primaryColorLight,
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
                  color: controller.isFavorite
                      ? Colors.red
                      : Theme.of(context).primaryColorLight,
                  size: 24,
                ),
                onPressed: () {
                  controller.setIsMealFavorite(mealId, !controller.isFavorite);
                },
              ),
          ],
          title: Text(
            controller.singleRes?.strMeal.toString() ?? "",
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
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
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),

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
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColorLight,
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
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColorLight,
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
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () => launchUrl(Uri.parse(
                              controller.singleRes!.strYoutube.toString())),
                          child: const Center(
                            child: Text(
                              '--------------Source Link--------------',
                              // maxLines: 8,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
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
